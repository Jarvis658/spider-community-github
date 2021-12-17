import React, { Component } from 'react'
import './register.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Button, Space, Toast, List, Input } from 'antd-mobile'
import { LockOutline, UserOutline } from 'antd-mobile-icons'

class Register extends Component {
    constructor() {
        super();
        this.state = {
            userId: "",
            password: "",
        }
    }

    render() {
        return (
            <div>
                <img className="img1" src="http://r31xm6gn5.hd-bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20211205171605.jpg" />

                <div className="logo">
                    <img className="img2" src="http://r31xm6gn5.hd-bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20211205171657.png" />
                </div>

                <text className="title_">Spider社区</text>

                <div className="login">

                    <div>
                        <UserOutline className="textImg" fontSize="40px"/>
                        <input id="user_id" className="id" placeholder='请输入用户名' clearable />
                    </div>

                    <div>
                        <LockOutline className="textImg" fontSize="40px"/>
                        <input id="user_pwd" type="password" className="pwd" placeholder='请输入密码' />
                    </div>

                    <Button className="loginButton" shape='rounded' fill="outline" color='default' onClick={this.login.bind(this)}>
                        注册
                    </Button>

                    <text className="registerLogin" onClick={() => {this.toRegister()} }>已有账号，返回登陆</text>

                </div>
            </div>
        )
    }


    login() {
        
        $axios.post('/user/login/register', {
            "u_id": document.getElementById("user_id").value,
            "u_pwd": document.getElementById("user_pwd").value
        }).then(res => {
            console.log(res.message)
            if (res.code == 200) {
                Toast.show({
                    content: '注册成功！已自动登录！',
                    afterClose: () => {
                        this.props.history.push({ pathname: '/home', state: { userId: res.message } })
                    },
                })
            }
            else {
                Toast.show({
                    content: '用户名已被注册',
                })
            }
        })
    }
}

export default Register