<template>
  <a-button @click="uploadAvatar">修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false" @change="handleFile">
</template>
<script>
    export default{
        data(){
            avatarFile: null
        },
        methods: {
        uploadAvatar() {
            this.$refs.avatarRef.click();
            
        },
        handleFile(){
            this.avatarFile = this.$refs.avatarRef.files[0];
        }
        }
    }
</script>
<style>

</style>
