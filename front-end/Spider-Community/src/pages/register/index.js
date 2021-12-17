import React, { Component } from 'react'
import './register.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Button, Space, Toast, List, Input } from 'antd-mobile'
import { LockOutline, UserOutline, PhonebookOutline, CollectMoneyOutline } from 'antd-mobile-icons'

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
                        <UserOutline className="textImg" fontSize="40px" />
                        <input id="user_id" className="id" placeholder='请输入用户名' clearable />
                    </div>

                    <div>
                        <LockOutline className="textImg" fontSize="40px" />
                        <input id="user_pwd" type="password" className="pwd" placeholder='请输入密码' />
                    </div>

                    <div>
                        <PhonebookOutline className="textImg" fontSize="40px" />
                        <input id="user_phone" className="phone" placeholder='请输入手机号' />
                    </div>

                    <div>
                        <CollectMoneyOutline className="textImg" fontSize="40px" />
                        <input id="user_code" className="code" placeholder='验证码' />
                        <Button shape='rounded' fill="outline" color='default' onClick={this.sendMessage.bind(this)}>
                            获取验证码
                        </Button>
                    </div>

                    <Button className="registerButton" shape='rounded' fill="outline" color='default' onClick={this.register.bind(this)}>
                        注册
                    </Button>

                    <text className="registerLogin" onClick={() => { this.toRegister() }}>已有账号，返回登陆</text>

                </div>
            </div>
        )
    }

    sendMessage() {
        const InspireCloud = require('@byteinspire/js-sdk')
        const serviceId = 'qcdy4y' // 替换成你的 serviceId，可在后台「设置」页面获取
        const inspirecloud = new InspireCloud({ serviceId })
        const phoneNumber = document.getElementById("user_phone").value

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


    async register() {

        const checkRes = await $axios.post('/user/register/check', {
            "u_name": document.getElementById("user_id").value,
            "u_pwd": document.getElementById("user_pwd").value,
            "u_phone": document.getElementById("user_phone").value,

        })

        // 当输入符合要求时
        if (checkRes.code === 200) {
            // 检查验证码
            var verifyRes = await this.verifyCode()     

            if (verifyRes === true) {
                // 数据库写入 进行注册
                $axios.post('/user/register', {
                    "u_name": document.getElementById("user_id").value,
                    "u_pwd": document.getElementById("user_pwd").value,
                    "u_phone": document.getElementById("user_phone").value,

                }).then(res => {
                    if (res.code == 200) {
                        Toast.show({
                            content: '注册成功！已自动登录！',
                            afterClose: () => {
                                this.props.history.push({ pathname: '/home', state: { userId: res.message } })
                            },
                        })
                    }
                    else {
                        Toast.show(res.message)
                    }
                })
            }
            else { Toast.show("验证码错误！") }

        }
        // 输入不符合要求时的报错
        else { Toast.show(checkRes.message) }
    }

    toRegister() {
        this.props.history.push({ pathname: '/login' })
    }


}

export default Register