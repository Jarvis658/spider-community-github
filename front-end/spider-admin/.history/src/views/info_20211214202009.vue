<template>
  <a-button @click="uploadAvatar">修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false" @change="handleFile">
</template>
<script>
    export default{
        data(){
            avatarFile= null,
            admin_id= 200
        },
        methods: {
        uploadAvatar() {
            this.$refs.avatarRef.click();
            let avatarForm = new FormData();
            avatarForm.append("avatar", this.avatarFile);
            avatarForm.append("admin_id",this.admin_id);
            
        },
        handleFile(){
            this.avatarFile = this.$refs.avatarRef.files[0];
        }
        }
    }
</script>
<style>

</style>
