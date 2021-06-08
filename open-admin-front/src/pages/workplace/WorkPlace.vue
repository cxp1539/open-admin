<template>
  <page-layout :avatar="currUser.avatar" :style="{minHeight: '736px'}">
    <div slot="headerContent">
      <div class="title">{{timeFix[lang]}}，{{currUser.name}}</div>
    </div>
    <template>
      <a-card :bordered="false">
        <div style="display: flex; flex-wrap: wrap">
            <head-info title="我的待办" content="8个任务" :bordered="true"/>
            <head-info title="本周任务平均处理时间" content="32分钟" :bordered="true"/>
            <head-info title="本周完成任务数" content="24个"/>
        </div>
      </a-card>
    </template>
  </page-layout>
</template>

<script>
import PageLayout from "@/layouts/PageLayout";
import { mapState } from "vuex";
import { request } from "@/utils/request";
import { timeFix } from "@/utils/util"
import HeadInfo from '../../components/tool/HeadInfo'
export default {
  name: "WorkPlace",
  components: { PageLayout, HeadInfo },
  data() {
    return {
      timeFix: timeFix()
    };
  },
  computed: {
    ...mapState("account", { currUser: "user" }),
    ...mapState("setting", ["lang"])
  },
  created() {
  }
};
</script>

<style lang="less">
</style>
