<template>
  <div id="app">
    <header-page @logout="logout" :logged="logged" :user="user"></header-page>
    <div v-if="logged">
      <h2>ホームページ</h2>
      <p id="profile_name">Name: {{user.name}}</p>
      <p id="profile_user_name">UserName: {{user.user_name}}</p>
      <p>Comment: {{ user.comment }}</p>
    </div>
  </div>
</template>
<script>

import axios from "axios";
import HeaderPage from '../layouts/header.vue';
import {reject, filter} from 'lodash';

export default {
  data() {
    return {
      user:{},
      logged: false,
    };
  },
  components: {
    HeaderPage,
  },
  created () {
    this.login_user();
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
};
</script>