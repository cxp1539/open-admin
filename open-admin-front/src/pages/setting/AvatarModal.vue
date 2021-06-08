<template>

  <a-modal
    title="修改头像"
    :visible="visible"
    :maskClosable="false"
    :confirmLoading="confirmLoading"
    :width="800"
    :footer="null"
    @cancel="cancelHandel">
    <a-row>
      <a-col :xs="24" :md="12" :style="{height: '350px'}">
        <vue-cropper
          ref="cropper"
          :img="options.img"
          :info="true"
          :autoCrop="options.autoCrop"
          :autoCropWidth="options.autoCropWidth"
          :autoCropHeight="options.autoCropHeight"
          :fixedBox="options.fixedBox"
          @realTime="realTime"
        >
        </vue-cropper>
      </a-col>
      <a-col :xs="24" :md="12" :style="{height: '350px'}">
        <div class="avatar-upload-preview">
          <img :src="previews.url" :style="previews.img"/>
        </div>
      </a-col>
    </a-row>
    <br>
    <a-row>
      <a-col :lg="2" :md="2">
        <a-upload name="file" :beforeUpload="beforeUpload" :showUploadList="false">
          <a-button icon="upload">选择图片</a-button>
        </a-upload>
      </a-col>
      <a-col :lg="{span: 1, offset: 2}" :md="2">
        <a-button icon="plus" @click="changeScale(1)"/>
      </a-col>
      <a-col :lg="{span: 1, offset: 1}" :md="2">
        <a-button icon="minus" @click="changeScale(-1)"/>
      </a-col>
      <a-col :lg="{span: 1, offset: 1}" :md="2">
        <a-button icon="undo" @click="rotateLeft"/>
      </a-col>
      <a-col :lg="{span: 1, offset: 1}" :md="2">
        <a-button icon="redo" @click="rotateRight"/>
      </a-col>
      <a-col :lg="{span: 2, offset: 6}" :md="2">
        <a-button type="primary" @click="finish()">保存</a-button>
      </a-col>
    </a-row>
  </a-modal>

</template>
<script>
import { VueCropper } from 'vue-cropper'
import { setSysUserInfo } from '@/services/system'
import { axios } from "@/utils/request";
const mime = require('mime');
export default {
  components: {
    VueCropper
  },
  data () {
    return {
      visible: false,
      id: null,
      confirmLoading: false,
      uploading: false,
      options: {
        img: '',
        autoCrop: true,
        autoCropWidth: 200,
        autoCropHeight: 200,
        fixedBox: true
      },
      previews: {}
    }
  },
  methods: {
    edit (id) {
      this.visible = true
      this.id = id
      /* 获取原始头像 */
    },
    close () {
      this.id = null
      this.visible = false
    },
    cancelHandel () {
      this.close()
    },
    changeScale (num) {
      num = num || 1
      this.$refs.cropper.changeScale(num)
    },
    rotateLeft () {
      this.$refs.cropper.rotateLeft()
    },
    rotateRight () {
      this.$refs.cropper.rotateRight()
    },
    beforeUpload (file) {
      const reader = new FileReader()
      // 把Array Buffer转化为blob 如果是base64不需要
      // 转化为base64
      reader.readAsDataURL(file)
      reader.onload = () => {
        this.options.img = reader.result
      }

      return false
    },

    // 上传图片（点击上传按钮）
    finish (type) {
      const _this = this
      const formData = new FormData()
      this.$refs.cropper.getCropData((data) => {
        this.model = true
        this.modelSrc = data
        let bytes=window.atob(data.split(',')[1]);
        let type = data.match(/:(.*?);/)[1];
        let ab = new ArrayBuffer(bytes.length);  
        let ia = new Uint8Array(ab);  

        for (var i = 0; i < bytes.length; i++) {  
            ia[i] = bytes.charCodeAt(i);  
        }
        formData.append('file', new File( [ab] , new Date().getTime()+"."+mime.getExtension(type) , {type : type}))
        formData.append('category', 'avatar')
        axios.post('/common/upload', formData, { contentType: false, processData: false, headers: { 'Content-Type': 'application/x-www-form-urlencoded' } })
          .then((res) => {
            if(res.code == 200){
              setSysUserInfo({avatar:res.data}).then(res1 => {
                if(res1.code == 200){
                  _this.$message.success('上传成功')
                  _this.$emit('ok', res.data)
                  _this.visible = false
                }else{
                  _this.$message.error(res1.message);
                }
              });  
            }
          }
        )
      })
    },
    okHandel () {
      const vm = this

      vm.confirmLoading = true
      setTimeout(() => {
        vm.confirmLoading = false
        vm.close()
        vm.$message.success('上传头像成功')
      }, 2000)
    },

    realTime (data) {
      this.previews = data
    }
  }
}
</script>

<style lang="less" scoped>

  .avatar-upload-preview {
    position: absolute;
    top: 50%;
    transform: translate(50%, -50%);
    width: 180px;
    height: 180px;
    border-radius: 50%;
    box-shadow: 0 0 4px #ccc;
    overflow: hidden;

    img {
      width: 100%;
      height: 100%;
    }
  }
</style>
