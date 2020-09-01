<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <h2>{{ showUser.user_name }}の詳細ページ</h2>
    <p id="profile_name">Name: {{showUser.name}}</p>
    <p id="profile_user_name">UserName: {{showUser.user_name}}</p>
    <p>Comment: {{ showUser.comment }}</p>
    <img :src="showUser.imgtext" alt="user_image" class="userImage">
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
          if (response.status === 200){
            this.user = response.data;
            this.logged = true;
          }else{
            this.logged = false;
          }
        })
    },
    logout: function() {
      axios
        .delete('/logout')
        .then(response => {
        if (response.status === 200) {
          this.user = {};
          this.logged = false;
          this.$router.go()
        }else if(res.status === 401){
          this.logged = false;
        }})
    }
  }
}
</script>

<style scoped>
.userImage{
  width: 400px;
  height: 400px;
}
</style>