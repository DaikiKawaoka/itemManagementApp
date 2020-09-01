<template>
  <div id="app">
    <header-page></header-page>
    <user-form :errors="errors" :user="user" @submit="createUser"></user-form>
  </div>
</template>
<script>
import axios from "axios";
import UserForm from './form.vue';
import HeaderPage from '../layouts/header.vue';

export default {
  components: {
    UserForm,
    HeaderPage,
  },
  created () {
    this.login_user();
  },
  data() {
    return {
      user: {
         name: '',
         user_name: '',
         email: '',
         comment: '',
         password: '',
         password_confirmation: '',
       },
       errors: ''
    };
  },
  methods: {
    createUser: function() {
      axios
        .post('/api/v1/users',this.user)
        .then(response => {
          let e = response.data;
          this.$router.push({ name: 'userShow', params: { id: e.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    login_user: function() {
      axios
        .get('/api/v1/sessions.json')
        .then(response => {
          if (response.status === 200){
            this.$router.push({ name: 'staticHome'})
          }
        })
    },
  }
};
</script>