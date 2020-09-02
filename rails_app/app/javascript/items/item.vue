<template>
  <div class="image">
    <router-link v-bind:to="{ name : 'itemShow', params : { id: item.id }}" class="a-tag">
    <div class="thumbs">
      <img :src="item.imgtext" alt="item_image" class="item-image">
    </div>
    </router-link>
    <span class="text-p"> {{item.name}}</span>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    item: {},
  },
  data: function () {
    return {
    }
  },
}
</script>

<style scoped>
.thumbs {
  width: 100%;
  max-width: 300px;
  position: relative;
}
.thumbs::before {
  content: "";
  display: block;
  padding-top: 100%;
}
.thumbs img {
  width: 300px;
  height: 300px;
  position: absolute;
  top: 0;
  object-fit: cover;
}
.main{
  display: flex;
}
.image{
  width: 300px;
}
.text{
  margin-top: 30px;
}
.text-p{
  font-size: 20px;
}
</style>