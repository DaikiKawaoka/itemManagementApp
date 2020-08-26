<template>
  <div id="app">
    <user-form :errors="errors" :user="user" @submit="createUser"></user-form>
  </div>
</template>
<script>
import axios from "axios";
import UserForm from './form.vue'

// import {reject, filter} from 'lodash';
export default {
  components: {
    UserForm,
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
    }
  }
};
</script>