<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <item-form :errors="errors" :user="user" :item="item" @submit="createItem"></item-form>
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
  },
  data() {
    return {
      user: {},
      logged: false,
      errors: '',
      item:{
        name:'',
        comment:'',
        assessment:'',
        item_type: 0,
        imgtext: '',
        item_image: '',
        favorite: false,
        price: 0,
        purchase_of_place: '',
        purchase_date: null,
      }
    };
  },
  methods: {
    createItem: function() {
      axios
        .post('/api/v1/items',this.item)
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
  }
};
</script>