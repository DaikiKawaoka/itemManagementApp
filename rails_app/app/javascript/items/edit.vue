<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <item-form :errors="errors" :user="user" :item="item" @submit="updateItem"></item-form>
  </div>
</template>
<script>
import axios from "axios";
import ItemForm from './form.vue';
import HeaderPage from '../layouts/header.vue';

export default {
  components: {
    ItemForm,
    HeaderPage,
  },
  created () {
    this.login_user();
    this.get_item();
  },
  data() {
    return {
      user: {},
      logged: false,
      errors: '',
      item:{}
    };
  },
  methods: {
    updateItem: function() {
      axios
        .patch(`/api/v1/items/${this.item.id}`, this.item)
        .then(response => {
          let e = response.data;
          this.$router.push({ name: 'itemShow', params: { id: e.id } });
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
            this.logged = true;
          }else{
            this.$router.push({ name: 'loginPage'})
          }
        })
    },
    get_item: function() {
      axios
        .get(`/api/v1/items/${this.$route.params.id}`)
        .then(response => (this.item = response.data))
    },
  }
};
</script>