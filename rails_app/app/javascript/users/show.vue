<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <h2>{{ showUser.user_name }}の詳細ページ</h2>
    <div class="main">
      <div class="image">
        <div class="thumbs">
          <img :src="showUser.imgtext" alt="user_image" class="userImage">
        </div>
      </div>
      <div class="text">
        <p id="profile_name" class="text-p">Name: {{showUser.name}}</p>
        <p id="profile_user_name" class="text-p">UserName: {{showUser.user_name}}</p>
        <p class="text-p">Comment: {{ showUser.comment }}</p>
        <p class="text-p">Email: {{ showUser.email }}</p>
        <el-button><router-link v-if="logged" v-bind:to="{ name : 'userEdit', params : { id: user.id }}" class="a-tag">Edit</router-link></el-button>
        <el-button v-if="logged" @click="logout">Logout</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import HeaderPage from '../layouts/header.vue';

export default {
  data: function () {
    return {
      user: {},
      showUser:{},
      logged: false,
    }
  },
  components: {
    HeaderPage,
  },
  created () {
    this.login_user();
  },
  mounted () {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => (this.showUser = response.data))
  },
  methods:{
    login_user: function() {
      axios
        .get('/api/v1/sessions.json')
        .then(response => {
          if (response.status === 201){
            this.$router.push({ name: 'loginPage'})
          }
            this.user = response.data;
            this.logged = true;
        })
    },
    logout: function() {
      axios
        .delete('/logout')
        .then(response => {
        if (response.status === 200) {
          this.user = {};
          this.logged = false;
          this.$router.push({ name: 'loginPage'})
        }else if(res.status === 401){
          this.logged = false;
        }})
    },
  }
}
</script>

<style scoped>
.thumbs {
  width: 100%;
  max-width: 400px;
  position: relative;
}
.thumbs::before {
  content: "";
  display: block;
  padding-top: 100%;
}
.thumbs img {
  width: 400px;
  height: 400px;
  position: absolute;
  top: 0;
  object-fit: cover;
}
.main{
  display: flex;
}
.image{
  width: 450px;
}
.text-p{
  font-size: 20px;
  padding-bottom: 15px;
}
.a-tag{
  font-size: 15px;
  color: #606266;
  text-decoration: none;
}
</style>