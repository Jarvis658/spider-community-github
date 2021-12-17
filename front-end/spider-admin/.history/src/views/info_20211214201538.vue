<template>
  <a-button @click="uploadAvatar">修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false" @change="handle">
</template>
<script>
    export default{
        data(){

        },
        methods: {
        uploadAvatar() {
            this.$refs.avatarRef.click()
        },
        han
        }
    }
</script>
<style>

</style>
