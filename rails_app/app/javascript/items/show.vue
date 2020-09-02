<template>
  <div id="app">
    <header-page :logged="logged" :user="user"></header-page>
    <div class="main">
      <div class="image">
        <div class="thumbs">
          <img :src="item.imgtext" alt="item_image" class="item-image">
        </div>
        <span class="star-rating">
          <p class="star-rating-front rate" v-bind:class="'rate'+item.assessment"></p>
        </span>
      </div>
      <div class="text">
        <p class="text-p">アイテム名: {{item.name}}</p>
        <p class="text-p">コメント: {{item.comment}}</p>
        <p class="text-p">タイプ: {{ item.item_type }}</p>
        <p class="text-p">購入日: {{ item.purchase_date }}</p>
        <p class="text-p">購入場所: {{ item.purchase_of_place }}</p>
        <p class="text-p">価格: {{ item.price }}</p>
        <p class="text-p">お気に入り: {{ item.favorite}}</p>
        <el-button v-if="logged"><router-link v-if="logged" v-bind:to="{ name : 'itemEdit', params : { id: item.id }}" class="a-tag">Edit</router-link></el-button>
        <el-button v-if="logged" @click="delete_item"><p class="a-tag">Delete</p></el-button>
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
      item:{},
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
      .get(`/api/v1/items/${this.$route.params.id}.json`)
      .then(response => (this.item = response.data))
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
    delete_item: function(){
      axios
        .delete("/api/v1/items/" + this.item.id)
        .then(response=>{
          if (response.status === 200) {
            this.item = {};
            this.$router.push({ name: 'staticHome'})
          }
        })
    }
  }
}
</script>

<style scoped>
/* .item-image{
  width: 400px;
  height: 400px;
} */
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
.text{
  margin-top: 30px;
}
.text-p{
  font-size: 20px;
  padding-bottom: 15px;
}
</style>