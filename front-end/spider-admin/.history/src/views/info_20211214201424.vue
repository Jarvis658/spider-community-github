<template>
  <a-button @click={} >修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false">
</template>
<script>
    export default{
        data(){

        },
        methods: {
        uploadAvatar() {
            this.$refs.uploadAvatar
        }
        }
    }
</script>
<style>

</style>
