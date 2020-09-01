<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <user-form :errors="errors" :user="user" @submit="updateUser" :edit="edit"></user-form>
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
  data() {
    return {
      user: {
        name: '',
        user_name: '',
        email: '',
        comment: '',
        imgtext: '',
        image: '',
      },
      errors: '',
      edit: true,
      logged: false,
    };
  },
  created () {
    this.login_user();
  },
  methods: {
    login_user: function() {
      axios
        .get('/api/v1/sessions.json')
        .then(response => {
          if (response.status === 200){
            this.user = response.data;
            this.logged = true;
          }else{
            this.$router.push({ name: 'loginPage'})
          }
        })
    },
    updateUser: function() {
      axios
        .patch(`/api/v1/users/${this.user.id}`,  this.user)
        .then(response => {
          this.$router.push({ name: 'userShow', params: { id: this.user.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  }
};
</script>
