<template>
  <a-button @click="uploadAvatar" >修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false">
</template>
<script>
    export default{
        uploadAvatar() {
            this.$refs.click();
        }
    }
</script>
<style>

</style>
