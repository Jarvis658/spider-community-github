<template>
  <a-button @click="uploadAvatar">修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false" @change="handle">
</template>
<script>
    export default{
        data(){
            avatarFile
        },
        methods: {
        uploadAvatar() {
            this.$refs.avatarRef.click()
        },
        handle(){

        }
        }
    }
</script>
<style>

</style>
