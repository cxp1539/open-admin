(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2d0cef60"],{"624b":function(e,t,a){"use strict";a.r(t);var r=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("a-card",{style:{minHeight:"560px"},attrs:{bordered:!1}},[a("div",{staticClass:"table-page-search-wrapper"},[a("a-form",{attrs:{layout:"inline"}},[a("a-row",{attrs:{gutter:48}},[a("a-col",{attrs:{md:7,sm:16}},[a("a-form-item",{attrs:{label:"操作人"}},[a("a-select",{attrs:{placeholder:"请选择","default-value":"0"},on:{change:e.change},model:{value:e.queryParam.operationId,callback:function(t){e.$set(e.queryParam,"operationId",t)},expression:"queryParam.operationId"}},[a("a-select-option",{attrs:{value:""}},[e._v("所有")]),e._l(e.sysUserList,(function(t,r){return a("a-select-option",{key:r,attrs:{value:t.id}},[e._v(e._s(t.name))])}))],2)],1)],1),a("a-col",{attrs:{md:14,sm:24}},[a("a-form-item",{attrs:{label:"审核时间"}},[a("a-form-item",{style:{display:"inline-block"}},[a("a-date-picker",{staticStyle:{width:"100%"},attrs:{format:e.dateFormat},on:{change:e.change},model:{value:e.queryParam.startTime,callback:function(t){e.$set(e.queryParam,"startTime",t)},expression:"queryParam.startTime"}})],1),a("span",{style:{display:"inline-block",width:"24px",textAlign:"center"}},[e._v("-")]),a("a-form-item",{style:{display:"inline-block",width:"calc(50% - 12px)"}},[a("a-date-picker",{staticStyle:{width:"100%"},attrs:{format:e.dateFormat},on:{change:e.change},model:{value:e.queryParam.endTime,callback:function(t){e.$set(e.queryParam,"endTime",t)},expression:"queryParam.endTime"}})],1)],1)],1)],1)],1)],1),a("s-table",{ref:"list",attrs:{rowKey:"id",size:"default",columns:e.columns,data:e.loadData,pageURI:!0,queryParam:e.queryParam},scopedSlots:e._u([{key:"operationId",fn:function(t){return a("span",{},[e._v(e._s(e.getOpertationName(t)))])}},{key:"url",fn:function(t){return a("span",{},[a("a-tag",[e._v(e._s(t))])],1)}},{key:"browser",fn:function(t){return a("span",{},[a("a-tag",[e._v(e._s(t))])],1)}},{key:"params",fn:function(t){return a("span",{attrs:{title:t}},[a("span",{attrs:{title:t}},[e._v(e._s(e._f("slice")(t)))])])}}])})],1)},n=[],s=(a("fb6a"),a("7db0"),a("b0c0"),a("c1df"),a("e8c4")),i=a("1d40"),l={name:"LogList",components:{STable:s["a"]},data:function(){var e=this;return{queryParam:{},modelTitle:"操作日志",visible:!1,labelCol:{xs:{span:24},sm:{span:5}},wrapperCol:{xs:{span:24},sm:{span:16}},sysUserList:[],dateFormat:"YYYY-MM-DD",columns:[{title:"Id",dataIndex:"id"},{title:"操作人",dataIndex:"operationId",scopedSlots:{customRender:"operationId"}},{title:"请求url",dataIndex:"url",scopedSlots:{customRender:"url"}},{title:"请求ip",dataIndex:"ip"},{title:"请求浏览器",dataIndex:"browser"},{title:"请求参数",dataIndex:"params",width:380,scopedSlots:{customRender:"params"}},{title:"执行时长(ms)",dataIndex:"takeTime"},{title:"请求时间",dataIndex:"createdTime",key:"createdTime"}],loadData:function(t){return Object(i["g"])(Object.assign(e.queryParam,t)).then((function(e){return e.data}))}}},created:function(){this.getSysUserList()},filters:{slice:function(e){return e&&e.length>118?e.slice(0,118)+"...":e}},methods:{change:function(){this.$refs.list.refresh()},getSysUserList:function(){var e=this;Object(i["l"])().then((function(t){e.sysUserList=t.data}))},getOpertationName:function(e){var t=this.sysUserList.find((function(t){return t.id==e}));return t?t.name:""}}},o=l,c=a("2877"),d=Object(c["a"])(o,r,n,!1,null,null,null);t["default"]=d.exports}}]);