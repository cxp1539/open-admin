import axios from "axios";
import Cookie from "js-cookie";

const xsrfHeaderName = "Authorization";

// 创建 axios 实例
const service = axios.create({
  withCredentials: true,
  baseURL: process.env.VUE_APP_API_BASE_URL, // api base_url
  timeout: 6000, // 请求超时时间
});

/**
 * 设置认证信息
 * @param auth {Object}
 */
function setAuthorization(auth) {
  Cookie.set(xsrfHeaderName, auth.token, { expires: auth.expireAt });
}

/**
 * 移出认证信息
 */
function removeAuthorization() {
  Cookie.remove(xsrfHeaderName);
}

/**
 * 检查认证信息
 * @param authType
 * @returns {boolean}
 */
function checkAuthorization() {
  if (Cookie.get(xsrfHeaderName)) {
    return true;
  } else {
    return false;
  }
}

/**
 * 加载 axios 拦截器
 * @param interceptors
 * @param options
 */
function loadInterceptors(interceptors, options) {
  const { request, response } = interceptors;
  // 加载请求拦截器
  request.forEach((item) => {
    let { onFulfilled, onRejected } = item;
    if (!onFulfilled || typeof onFulfilled !== "function") {
      onFulfilled = (config) => config;
    }
    if (!onRejected || typeof onRejected !== "function") {
      onRejected = (error) => Promise.reject(error);
    }
    service.interceptors.request.use(
      (config) => onFulfilled(config, options),
      (error) => onRejected(error, options)
    );
  });
  // 加载响应拦截器
  response.forEach((item) => {
    let { onFulfilled, onRejected } = item;
    if (!onFulfilled || typeof onFulfilled !== "function") {
      onFulfilled = (response) => response;
    }
    if (!onRejected || typeof onRejected !== "function") {
      onRejected = (error) => Promise.reject(error);
    }
    service.interceptors.response.use(
      (response) => onFulfilled(response, options),
      (error) => onRejected(error, options)
    );

  });

  service.interceptors.response.use((response) => {
    return response.data;
  })

}

/**
 * 解析 url 中的参数
 * @param url
 * @returns {Object}
 */
function parseUrlParams(url) {
  const params = {};
  if (!url || url === "" || typeof url !== "string") {
    return params;
  }
  const paramsStr = url.split("?")[1];
  if (!paramsStr) {
    return params;
  }
  const paramsArr = paramsStr.replace(/&|=/g, " ").split(" ");
  for (let i = 0; i < paramsArr.length / 2; i++) {
    const value = paramsArr[i * 2 + 1];
    params[paramsArr[i * 2]] =
      value === "true" ? true : value === "false" ? false : value;
  }
  return params;
}

export {
  service as axios,
  setAuthorization,
  removeAuthorization,
  checkAuthorization,
  loadInterceptors,
  parseUrlParams,
};
