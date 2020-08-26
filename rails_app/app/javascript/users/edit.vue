<template>
  <div id="app">
    <header-page></header-page>
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
      user: {},
      errors: '',
      edit: true,
    };
  },
  mounted () {
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response => (this.user = response.data))
  },
  methods: {
    updateUser: function() {
      axios
        .patch(`/api/v1/users/${this.user.id}`, this.user)
        .then(response => {
          this.$router.push({ name: 'userShow', params: { id: this.user.id } });
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