<template>
  <el-container class="header" >
    <el-header class="layouts">
      <router-link to="/" class="a-tag">Home</router-link>
      <router-link v-if="logged" v-bind:to="{ name : 'userShow', params : { id: user.id }}" class="a-tag">Profile</router-link>
      <router-link v-if="!logged" to="/users/new" class="a-tag">New</router-link>
      <!-- <el-button v-if="logged"><router-link v-bind:to="{ name : 'userEdit', params : { id: user.id }}" class="a-tag">Edit</router-link></el-button> -->
      <router-link v-if="logged" v-bind:to="{ name : 'itemNew'}" class="a-tag">CreateItem</router-link>
      <!-- <el-button v-if="logged" @click="$emit('logout')">Logout</el-button> -->
      <router-link v-if="!logged" to="/login" class="a-tag">Login</router-link>
      <!-- <router-link to="/users//edit">Edit</router-link> -->
    </el-header>
  </el-container>
</template>

<script>
import axios from 'axios'
export default {
  props: {
    user: {},
    logged: false,
  },
  methods:{
  }
}
</script>

<style scoped>
.header{
  border-bottom: #606266 solid 1px;
  height: 60px;
}
.a-tag{
  line-height: 60px;
  margin-right: 20px;
  font-size: 15px;
  text-align: right;
  color: #606266;
  text-decoration: none;
}
</style>