<template>
  <div @click="uploadAvatar" >修改头像</div>
<input type="file" ref="avatarRef" v-show="false">
</template>
<script>
    methods: {
        var that = this;
        uploadAvatar(){
            that.$refs.click();
        }
    }
</script>
<style>

</style>
