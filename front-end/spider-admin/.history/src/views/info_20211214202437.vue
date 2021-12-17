<template>
  <a-button @click="uploadAvatar">修改头像</a-button>
  <input type="file" ref="avatarRef" v-show="false" @change="handleFile" />
</template>
<script>
import { useRouter, useRoute } from "vue-router";
import { reactive, ref } from "vue";
import { get, post, setLocalToken, tip } from "@/common";
import { removeLocalToken } from "@/common/token.js";
    export default{
        data(){
            return {
              avatarFile: null,
              admin_id: 200
             };           
        },
        methods: {
        uploadAvatar() {
            this.$refs.avatarRef.click();
            let avatarForm = new FormData();
            avatarForm.append("avatar", this.avatarFile);
            avatarForm.append("admin_id",this.admin_id);
            post("admin/info/update_avatar",avatarForm).then((res) =>{
                alert(res.message)
            })
        },
        handleFile(){
            this.avatarFile = this.$refs.avatarRef.files[0];
        }
        }
    }
</script>
<style>
</style>
