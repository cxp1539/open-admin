import { axios } from "@/utils/request";

export function getUserList(params) {
    return axios({
      url: "/backed/user/list",
      method: "get",
      params
    });
}

export function exportExcel(params) {
  return axios({
    url: "/backed/user/exportExcel",
    method: "get",
    params,
    responseType: 'blob',
  });
}
