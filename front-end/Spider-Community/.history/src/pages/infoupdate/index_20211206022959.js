import React, { Component, Fragment, FC, useState, useRef } from 'react'
import './info.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import { Picker, Radio, NavBar, DatePicker, Selector, Slider, Stepper, TextArea, Form, Input, List, Space, Collapse, Card, Image, Toast, Button, Divider, Popup, Dialog } from 'antd-mobile'
import dayjs from 'dayjs'
// import { Upload } from 'antd'




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
        // const userId = this.props.location.state.userId


        return (
            <div className="P-home">
                <NavBar right={<div style={{ fontSize: 18 }}>
                    <Space>

                        <Button onClick={() => this.updateinfo()} color='primary' fill='none'>
                            提交
                        </Button>
                    </Space>
                </div>} onBack={() => this.goBackPage()}>
                    修改信息
                </NavBar>
                {/* 上传封面按钮 */}
                <div
                    className="coverUpload"
                    onClick={() => {
                        this.refs.coverRef.click();
                    }}
                    style={{ width: 200, height: 150, }}

                >
                    {/*          
                    <Image
                    src={this.state.useravatar}
                    width={96}
                    height={96}
                    fit='cover'
                    style={{ borderRadius: 32 }}//确定图像为圆形
                                        /> */}

                    <div ref='coverImg' >
                        <h7>

                            <img
                                width={72}
                                height={72}
                                fit='cover'

                                src={this.state.useravatar}
                                style={{ maxHeight: 300, borderRadius: 32, maxWidth: 300, }}></img>
                        </h7>
                    </div>

                </div>

                <List
                    style={{
                        '--prefix-width': '6em',
                    }}
                >
                    <List.Item title='用户名'>
                        <Input placeholder={this.state.username} clearable onChange={val => { this.setState({ username: val }) }} />
                    </List.Item>

                    <List.Item title='性别' onClick={() => {
                                this.setState({ selectvisible: true })
                            }}>
                        {/* <Space>

                                           <Radio onChange={() => this.setState({ usersex: 0 })}>男</Radio>
                                            <Radio onChange={() => this.setState({ usersex: 1 })}>女</Radio>
                                       </Space>
                                             */}
                       
                        <Picker
                            columns={this.state.basicColumns}
                            visible={this.state.selectvisible}
                            onClose={() => {
                                this.setState({ selectvisible: false })
                            }}
                            // value={this.state.usersex}
                            onConfirm={v => {
                                { this.setState({ usersex: v == "男" ? 1 : 2 }) }

                            }}
                        />


                    </List.Item>



                    {/* <List.Item title='生日' onClick={() => { this.setState({ PickerVisible: true })}}> */}
                    <List.Item title='生日' >
                        <Input placeholder={this.state.userbirthday} clearable onChange={val => { this.setState({ userbirthday: val }) }} />
                        {/* <DatePicker
                            visible={this.state.pickerVisible}
                            onClose={() => {
                            this.setState({ pickerVisible: false })
                            }}
                        >
                            {value =>
                                value ? dayjs(value).format('YYYY-MM-DD') : '请选择日期'
                            }
                        </DatePicker> */}
                    </List.Item>
                    {/* <Form.Item
            name='birthday'
            label='生日'
            trigger='onConfirm'
            onClick={() => {
              setPickerVisible(true)
            }}
          >
            <DatePicker
              visible={pickerVisible}
              onClose={() => {
                setPickerVisible(false)
              }}
            >
              {value =>
                value ? dayjs(value).format('YYYY-MM-DD') : '请选择日期'
              }
            </DatePicker>
          </Form.Item> */}


                    <List.Item title='学校'>
                        <Input placeholder={this.state.userschool} clearable onChange={val => { this.setState({ userschool: val }) }} />
                    </List.Item>
                    {/* <List.Item title='头像'>
                        <Input placeholder="" clearable  onChange={val => { this.setState({useravatar: val}) }} />
                    </List.Item> */}
                    <List.Item title='个性宣言'>
                        <Input placeholder={this.state.usersignature} clearable onChange={val => { this.setState({ usersignature: val }) }} />
                    </List.Item>
                </List>


                <Space wrap align='center'>

                    <Button
                        size='large'
                        block
                        style={{ width: 340 }}
                        onClick={() => this.setState({ Visible1: true })}
                    >
                        修改密码</Button>
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

                </Space>




                {/* 上传封面 
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
                </Upload> */}


            </div>
        )
    }

    componentDidMount() {

        this.setState({ userId: this.props.location.state.userId });
        $axios.post('/user/info/view', {
            "uid": this.props.location.state.userId,

        }).then(res => {
            console.log(res)
            this.setState({

                // password: res.data.user_password,
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
        this.props.history.go(-2)
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
            // "user_avatar": this.state.useravatar,
            "user_birthday": this.state.userbirthday,
            "user_signature": this.state.usersignature,
            "user_name": this.state.username,
            "school_name": this.state.userschool,
            "user_avatar": this.state.useravatar,


        }).then(res => {
            console.log(res)
            this.setState({
                // password: res.data.user_password,
                // username: res.data.user_name,
                // userschool: res.data.school_name,
                // usersignature: res.data.user_signature,
                // useravatar: res.data.user_avatar,
                // userbirthday: res.data.user_birthday,
                // usersex: res.data.user_sex,

            })
        })
        this.props.history.push({ pathname: '/info', state: { userId: this.state.userId } })

    }


    beforeUpload(file) {
        // Toast.show({
        //     icon: 'loading',
        //     content: '加载中…',
        //     duration: 3000
        // })
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

            // //将图片插入编辑器
            // const addImageRange = this.editor.getSelection();
            // const cursorPosition = 0 + (addImageRange !== null ? addImageRange.index : 0);
            // this.editor.insertEmbed(cursorPosition, 'image', uploadUrl);//插入图片//react无法读本地图片！！
            // this.editor.setSelection(cursorPosition + 1);//光标位置加1
        }
    }

}

export default InfoUpdate