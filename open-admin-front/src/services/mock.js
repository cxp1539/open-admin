import { axios } from "@/utils/request";

export async function goodsList(params) {
  return axios({
    url: `/backed/mock/goods`,
    method: "get",
    params,
  });
}