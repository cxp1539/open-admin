<template>
  <a-card :bordered="false" :style="{minHeight: '592px'}">

    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="48">

          <a-col :md="7" :sm="16">
            <a-form-item label="昵称">
              <a-input-search
                v-model="queryParam.nickname"
                placeholder="请输入昵称"
                enter-button="搜索"
                @search="search"
              />
            </a-form-item>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="exportExcel">导出用户</a-button>
    </div>

    <s-table ref="list" rowKey="id" size="default" :columns="columns" :data="loadData">
      <span slot="action" slot-scope="text, record">
        <template>
          <a @click="handleInfo(record)">
            <a-icon type="info-circle" />详情
          </a>
        </template>
      </span>

      <span slot="nickname" slot-scope="text, record">
        <img style="width:42px;height:42px;border-radius:50%;" :src="record.avatarUrl" />
        <a-icon style="margin-left:6px;" v-if="record.gender == 1" type="man" />
        <a-icon style="margin-left:6px;" v-if="record.gender == 2" type="woman" />
        {{ record.nickname }}
      </span>

      <span slot="status" slot-scope="status">
        <a-badge :color="status | statusTypeFilter" :text="status | statusFilter"/>
      </span>

    </s-table>  

  </a-card>
</template>

<script>
import STable from '@/components/table'
import { getUserList, exportExcel } from '@/services/user'
import { statusMap } from '@/enums/user';
export default {
  name: 'UserList',
  components: {
    STable
  },
  data() {
    return {
      // 查询参数
      queryParam: {},
      layout: {
        labelCol: { span: 4 },
        wrapperCol: { span: 14 },
      },
      visible: false,
      rolesMap: [],
      form: this.$form.createForm(this),
      statusMap: statusMap,
      labelCol: {
        xs: { span: 24 },
        sm: { span: 5 }
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 }
      },
      mdl: {},
      // 表头
      columns: [
        {
          title: 'Id',
          dataIndex: 'id',
          key: 'id',
        },
        {
          title: '昵称',
          dataIndex: 'nickname',
          key: 'nickname',
          scopedSlots: { customRender: 'nickname' }
        },
        {
          title: 'openid',
          dataIndex: 'openid',
          key: 'openid',
        },
        {
          title: '手机号',
          dataIndex: 'mobile',
          key: 'mobile',
        },
        {
          title: '状态',
          dataIndex: 'status',
          scopedSlots: { customRender: 'status' },
          key: 'status',
        },
        {
          title: '创建时间',
          dataIndex: 'createdTime',
          key: 'createdTime',
        },
        {
          title: '操作',
          width: '150px',
          dataIndex: 'action',
          scopedSlots: { customRender: 'action' },
          key: 'action',
        }
      ],
      loadData: parameter => {
        this.queryParam = Object.assign({},this.queryParam, parameter);
        return getUserList(this.queryParam).then(res => {
          return res.data
        })
      },
    }
  },
  created(){
  },
  filters: {
    statusFilter (status) {
      let res = statusMap.find(item => {
        return item.id == status;
      });
      if(res){
        return res.name;
      }
    },
    statusTypeFilter (type) {
      let res = statusMap.find(item => {
        return item.id == type;
      });
      if(res){
        return res.color;
      }
    }
  },
  methods: {
    search(){
      this.$refs.list.refresh(1);
    },
    exportExcel() {
      exportExcel(this.queryParam).then((res) => {
        let blob = new Blob([res])
        let downloadElement = document.createElement('a');
        let href = window.URL.createObjectURL(blob); //创建下载的链接
        downloadElement.href = href;
        downloadElement.download = '用户列表.xlsx'; //下载后文件名
        document.body.appendChild(downloadElement);
        downloadElement.click(); //点击下载
        document.body.removeChild(downloadElement); //下载完成移除元素
        window.URL.revokeObjectURL(href); //释放掉blob对象
      })
    },
    handleInfo(record){
      this.$message.success("info");
    }
  }
}
</script>
