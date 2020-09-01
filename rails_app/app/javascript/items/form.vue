<template>
  <el-form :model="item">
    <h2 v-if="edit">アイテム編集</h2>
    <h2 v-else>アイテム作成</h2>
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>

    <input name="uploadedImage" type="file" ref="file" v-on:change="onFileChange()" class="file-up">

    <el-form-item label="タイプ">
      <el-select v-model="item.item_type" clearable placeholder="Select">
        <el-option
          v-for="items in options_type"
          :key="items.value"
          :label="items.label"
          :value="items.value">
        </el-option>
      </el-select>
    </el-form-item>

    <el-form-item label="タイトル名">
      <el-input
        placeholder="Please title"
        v-model="item.name"
        clearable>
      </el-input>
    </el-form-item>

    <el-form-item label="コメント">
      <el-input
        type="textarea"
        :autosize="{ minRows: 2, maxRows: 4}"
        placeholder="Please comment"
        v-model="item.comment">
      </el-input>
    </el-form-item>

    <el-form-item label="自己評価">
      <el-select v-model="item.assessment" clearable placeholder="Select">
        <el-option
          v-for="items in options_assessment"
          :key="items.value"
          :label="items.label"
          :value="items.value">
        </el-option>
      </el-select>
    </el-form-item>

    <el-form-item label="価格">
      <template>
        <el-input-number v-model="item.price" :min="0" :max="100000000" :step="500"></el-input-number>
      </template>
    </el-form-item>

    <el-form-item label="購入元">
      <el-input
        placeholder="Please input"
        v-model="item.purchase_of_place"
        clearable>
      </el-input>
    </el-form-item>

    <el-form-item>
      <div class="block">
        <span class="demonstration">Date</span>
        <el-date-picker
          v-model="item.purchase_date"
          type="date"
          placeholder="Pick a date"
          default-value="2020-09-01">
        </el-date-picker>
      </div>
    </el-form-item>

    <el-form-item>
      <el-button type="submit" @click="$emit('submit')">登録</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import axios from 'axios'

 export default {
   props: {
    user: {},
    item: {},
    errors: '',
    edit: false,
  },
  data() {
    return{
      options_type: [{
          value: 1,
          label: 'ファッション'
        }, {
          value: 2,
          label: '書籍'
        }, {
          value: 3,
          label: 'ゲーム'
        }, {
          value: 4,
          label: 'コスメ'
        }, {
          value: 5,
          label: '家電'
        }, {
          value: 6,
          label: '食料品'
        }, {
          value: 7,
          label: '音楽'
        }, {
          value: 8,
          label: '日用品'
        }, {
          value: 9,
          label: '薬'
        }, {
          value: 10,
          label: '文房具'
        }, {
          value: 11,
          label: 'スポーツ＆アウトドア'
        }, {
          value: 12,
          label: '乗り物'
        }, {
          value: 13,
          label: 'ベビー、おもちゃ'
        }, {
          value: 14,
          label: '家具'
        }, {
          value: 15,
          label: 'パソコン、オフィス用品'
        }, {
          value: 16,
          label: 'その他'
        }
        ],

        options_assessment: [{
          value: '0-0',
          label: '0'
        }, {
          value: '0-5',
          label: '0.5'
        }, {
          value: '1-0',
          label: '1'
        }, {
          value: '1-5',
          label: '1.5'
        }, {
          value: '2-0',
          label: '2'
        }, {
          value: '2-5',
          label: '2.5'
        }, {
          value: '3-0',
          label: '3'
        }, {
          value: '3-5',
          label: '3.5'
        }, {
          value: '4-0',
          label: '4'
        }, {
          value: '4-5',
          label: '4.5'
        }, {
          value: '5-0',
          label: '5'
        }
        ],

      uploadedImage: '',
    }
    },
    methods: {
      onFileChange() {
      let file = event.target.files[0] || event.dataTransfer.files
      let reader = new FileReader()
      reader.onload = () => {
        this.uploadedImage = event.target.result
        this.item.image = this.uploadedImage
      }
      reader.readAsDataURL(file)
    },
    }
 }
</script>

<style scoped>
.file-up{
  margin-bottom: 30px;
}
</style>