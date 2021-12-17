import React, { Component } from 'react'
import './login.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Button, Space, Toast, List, Input } from 'antd-mobile'
import { LockOutline, UserOutline, CollectMoneyOutline } from 'antd-mobile-icons'

class phoneLogin extends Component {
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
                        <UserOutline className="textImg" fontSize="40px" />
                        <input id="user_phone" className="id_" placeholder='请输入手机号' clearable />
                    </div>

                    <div>
                        <CollectMoneyOutline className="textImg" fontSize="40px" />
                        <input id="user_code" className="code" placeholder='验证码' />
                        <Button shape='rounded' fill="outline" color='default' onClick={this.sendMessage.bind(this)}>
                            获取验证码
                        </Button>
                    </div>

                    <Button className="loginButton" shape='rounded' fill="outline" color='default' onClick={this.login.bind(this)}>
                        登录
                    </Button>

                    <text className="normalLogin" onClick={() => { this.toLogin() }}>账号密码登录</text>
                    <text className="register" onClick={() => { this.toRegister() }}>点击注册</text>

                </div>
            </div>
        )
    }


    async login() {
        var verifyRes = await this.verifyCode()

        if (verifyRes === true) {
            $axios.post("/user/login/getUid", {
                "u_id": document.getElementById("user_phone").value,
                "u_pwd": ""
            }).then(res => {
                Toast.show({
                    content: '登录成功！',
                    afterClose: () => {
                        this.props.history.push({ pathname: '/home', state: { userId: res.data } })
                    },
                })
            })
        }
        else Toast.show("验证码错误！")

    }

    async sendMessage() {
        const InspireCloud = require('@byteinspire/js-sdk')
        const serviceId = 'qcdy4y' // 替换成你的 serviceId，可在后台「设置」页面获取
        const inspirecloud = new InspireCloud({ serviceId })
        const phoneNumber = document.getElementById("user_phone").value
        const phoneCheckRes = await $axios.post("/user/login/checkPhone", {
            "u_id": document.getElementById("user_phone").value,
            "u_pwd": ""
        })

        console.log("this is phone check ", phoneCheckRes.success)

        if (phoneCheckRes.success === true) {
            return inspirecloud.run('sendMessageAPI', {
                phoneNumber
            }).then(res => {
                console.log("send message result ", res.success);
                if (res.success === true) {
                    Toast.show("验证码已发送！")
                    return
                }
                else {
                    Toast.show("手机号输入不正确！")
                }
            })
        }
        else Toast.show(phoneCheckRes.message)

    }

    async verifyCode() {
        const InspireCloud = require('@byteinspire/js-sdk')
        const serviceId = 'qcdy4y'; // 替换成你的 serviceId，可在后台「设置」页面获取
        const inspirecloud = new InspireCloud({ serviceId });
        const phoneNumber = document.getElementById("user_phone").value
        const code = document.getElementById("user_code").value
        var result
        await inspirecloud.run('loginByPhone', {
            phoneNumber,
            code
        }).then(res => {

            result = res.success
            console.log("code verify success: ", result)
        })

        return result
    }


    toLogin() {
        this.props.history.push({ pathname: '/login' })
    }

    toRegister() {
        this.props.history.push({ pathname: '/register' })
    }
}

export default phoneLogin