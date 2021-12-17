<template>
  <a-button @click={this.refs} >修改头像</a-button>
<input type="file" ref="avatarRef" v-show="false">
</template>
<script>
    export default{
        data(){

        },
        methods: {
        uploadAvatar() {

        }
        }
    }
</script>
<style>

</style>
