<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <div v-if="logged">
      <h2>ホームページ</h2>
      <div class="item-divs">
        <div v-for="item of items" :key="item.id" class="item-div">
          <item-pane v-bind:row="item.number" :item ="item"></item-pane>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

import axios from "axios";
import HeaderPage from '../layouts/header.vue';
import ItemPane from '../items/item.vue';
import {reject, filter} from 'lodash';

export default {
  data() {
    return {
      user:{},
      items:[],
      logged: false,
    };
  },
  components: {
    HeaderPage,
    ItemPane
  },
  created () {
    this.login_user();
    // if (logged){
      // axios.get("/api/v1/items").then(res => {
      //   this.items = res.data;
      // });
    // }
  },
  methods:{
    login_user: function() {
      axios
        .get('/api/v1/sessions.json')
        .then(response => {
          if (response.status === 201){
            this.$router.push({ name: 'loginPage'})
          }else{
            this.user = response.data;
            this.logged = true;
            axios.get("/api/v1/items").then(res => {
              this.items = res.data;
            });
          }
        })
    },
  }
};
</script>

<style scoped>
.item-divs{
  width: 1000px;
  display: flex;              /* フレックスボックスにする */
  justify-content:flex-start;
  flex-wrap: wrap;
}
.item-div{
  margin-left: 30px;
  margin-bottom: 25px;
}
</style>