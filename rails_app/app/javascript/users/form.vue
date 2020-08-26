<template>
  <el-form :model="user">

    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>

    <el-form-item label="名前">
      <el-input
        v-model="user.name"
        placeholder="name"
        name="user[name]"></el-input>
    </el-form-item>
    <el-form-item label="ユーザーネーム">
      <el-input
        v-model="user.user_name"
        placeholder="user_name"
        name="user[user_name]"></el-input>
    </el-form-item>

    <el-form-item label="コメント" v-if="edit">
      <el-input
        v-model="user.comment"
        placeholder="comment">
      </el-input>
    </el-form-item>

    <el-form-item
    label="メールアドレス" prop="email"
    :rules="[
        { required: true, message: 'タイトルは必ず入力してください。' },
        { max: 30, message: '30文字以内で入力してください。' },
        { type: 'email', message: 'メール形式で入力してください。' }
    ]">
        <el-input type="text" v-model="user.email" autocomplete="off"></el-input>
    </el-form-item>

    <el-form-item label="パスワード" prop="password">
        <el-input type="password" v-model="user.password" autocomplete="off"></el-input>
    </el-form-item>

    <el-form-item label="パスワード確認" prop="password">
        <el-input type="password" v-model="user.password_confirmation" autocomplete="off"></el-input>
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
    errors: '',
    edit: false,
  },
 }
</script>