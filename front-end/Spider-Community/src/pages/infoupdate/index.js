import React, { Component, Fragment, FC, useState, useRef } from 'react'
import './infoupdate.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import { Picker, Radio, NavBar, DatePicker, Selector, Slider, Stepper, TextArea, Form, Input, List, Space, Collapse, Card, Image, Toast, Button, Divider, Popup, Dialog } from 'antd-mobile'
import { Upload } from 'antd'

class InfoUpdate extends Component {
    constructor() {

        super();
        this.state = {
            userId: "",
            password: "",
            username: "",
            userschool: "",
            usersignature: "",
            useravatar: "",
            usersex: "",
            userbirthday: "",
            pickerVisible: false,
            Visible1: "",
            passwordtest: "",
            passwordupdate: "",
            currentAvatarUrl: null,
            basicColumns: [["女", "男"]],
            selectvisible: false,
        }
    }

    render() {
        return (
            <div>
                <NavBar right={
                    <div style={{ fontSize: 18 }}>
                        <Button onClick={() => this.updateinfo()} color='primary' fill='none'>
                            提交
                        </Button>
                    </div>} onBack={() => this.goBackPage()}>
                    修改信息
                </NavBar>
                {/* 上传封面按钮 */}
                <div className="content-info">
                    <div className="avatarUpload" onClick={() => { this.refs.coverRef.click();}}>
                        <img
                            width={72}
                            height={72}
                            fit='cover'
                            src={this.state.useravatar}
                            style={{ maxHeight: 300, borderRadius: 50, maxWidth: 300}}>
                        </img>
                    </div>
                    <div className="Lists">                       
                        <List style={{'--prefix-width': '6em',}}>
                            <List.Item title='用户名'>
                                <Input placeholder={this.state.username} clearable onChange={val => { this.setState({ username: val }) }} />
                            </List.Item>
                            <List.Item title='性别' onClick={() => {
                                        this.setState({ selectvisible: true })
                                    }}> 
                                <Picker
                                    columns={this.state.basicColumns}
                                    visible={this.state.selectvisible}
                                    onClose={() => {
                                        this.setState({ selectvisible: false })
                                    }}
                                    onConfirm={v => {
                                        { this.setState({ usersex: v == "男" ? 1 : 2 }) }
                                    }}
                                />
                            </List.Item>
                            <List.Item title='生日' >
                                <Input placeholder={this.state.userbirthday} clearable onChange={val => { this.setState({ userbirthday: val }) }} />
                            </List.Item>
                            <List.Item title='学校'>
                                <Input placeholder={this.state.userschool} clearable onChange={val => { this.setState({ userschool: val }) }} />
                            </List.Item>
                            <List.Item title='个性签名'>
                                <Input placeholder={this.state.usersignature} clearable onChange={val => { this.setState({ usersignature: val }) }} />
                            </List.Item>
                        </List>
                    </div>
                    <div>
                        <Button
                            size='large'
                            block
                            style={{ width: 340, }}
                            onClick={() => this.setState({ Visible1: true })}>
                            修改密码
                        </Button>
                    </div>
                </div>
                
                    <Popup
                        visible={this.state.Visible1}
                        onMaskClick={() =>
                            this.setState({ Visible1: false })}
                        bodyStyle={{ minHeight: '40vh' }}>
                        <List style={{ '--prefix-width': '6em', }}>
                            <List.Item title='旧密码'>
                                <Input clearable onChange={val => { this.setState({ passwordtest: val }) }} />
                            </List.Item>
                            <List.Item title='新密码'>
                                <Input clearable onChange={val => { this.setState({ passwordupdate: val }) }} />
                            </List.Item>
                        </List>
                        <Button block onClick={() => this.updatepassword()} size='large'>
                            提交
                              </Button>
                    </Popup>

                <Upload
                    name='file'
                    action='http://upload.qiniu.com'
                    data={
                        {
                            'token': this.state.uploadToken,
                            'fileKey': Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1
                        }
                        // this.getUploadToken
                    }
                    beforeUpload={this.beforeUpload.bind(this)}
                    onChange={this.handleUploadChange}
                    showUploadList={false}
                >
                    <button ref="coverRef" style={{ display: "none" }}>
                        Click to Upload
                    </button>
                </Upload>
            </div>
        )
    }

    componentWillMount() {
        this.setState({ userId: this.props.location.state.userId });
        $axios.post('/user/info/view', {
            "uid": this.props.location.state.userId,

        }).then(res => {
            console.log(res)
            this.setState({
                username: res.data.user_name,
                userschool: res.data.school_name,
                usersignature: res.data.user_signature,
                useravatar: res.data.user_avatar,
                userbirthday: res.data.user_birthday,
                usersex: res.data.user_sex,
                password: res.data.user_password,
                uploadToken: '',
                fileKey: '',
                currentAvatarUrl: res.data.user_avatar,
            })
        })
        this.fetchUploadToken();
    }

    goBackPage = () => {
        //返回上一页这段代码
        this.props.history.go(-1);
    }

    updatepassword() {
        if (this.state.passwordtest == this.state.password) {

            $axios.post('/user/info/update_password', {
                "user_id": this.props.location.state.userId,
                "user_password": this.state.passwordupdate,
            })
            this.setState({ Visible1: false })
        } else {
            Toast.show({
                content: '原密码错误！',
            })
        }
    }

    updateinfo() {

        $axios.post('/user/info/update', {
            "user_id": this.props.location.state.userId,
            "user_sex": this.state.usersex,
            "user_birthday": this.state.userbirthday,
            "user_signature": this.state.usersignature,
            "user_name": this.state.username,
            "school_name": this.state.userschool,
            "user_avatar": this.state.useravatar,
        }).then(res => {
            console.log(res)
        })
        this.props.history.push({ pathname: '/info', state: { userId: this.props.location.state.userId } })
    }

    beforeUpload(file) {
        return true;
    }

    // 访问后端，获取请求上传凭证
    fetchUploadToken = () => {
        $axios.get('/upload/token/get', {}).then(res => {
            Toast.clear();
            console.log(res);
            this.setState({
                uploadToken: res.message,
                fileKey: Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1
            })
        })
    }

    // 获取上传凭证
    getUploadToken = () => {
        return {
            token: this.state.uploadToken,
            key: this.state.fileKey
        }
    }

    // 获取回传的文件地址
    handleUploadChange = info => {
        if (info.file.status === 'done') {
            const imageKey = info.file.response.key
            const uploadUrl = "http://r31xm6gn5.hd-bkt.clouddn.com/" + imageKey;
            console.log(uploadUrl);
            this.setState({ useravatar: uploadUrl })
        }
    }
}

export default InfoUpdate