import React, { Component, Fragment, FC, useState, useRef } from 'react'
import './info.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import { Picker, Empty, JumboTabs, NavBar, Radio, Badge, TabBar, Input, List, Space, Collapse, Card, Image, Toast, Button, Divider, Popup, Dialog } from 'antd-mobile'
import { UnorderedListOutline, PayCircleOutline, SetOutline, MessageOutline, MessageFill, AppOutline, UserOutline, } from 'antd-mobile-icons'
import { sleep } from '../../common/request'
import { EditSOutline, LikeOutline, SmileOutline, HeartOutline, StarOutline, UserCircleOutline, AntOutline, RightOutline, ExclamationCircleFill } from 'antd-mobile-icons'
import styles from './index.less'
import { DialogShowRef } from 'antd-mobile/es/components/dialog'
import { thisExpression } from '@babel/types';
import { Route, Switch, useHistory, useLocation, MemoryRouter as Router, } from 'react-router-dom'


class Info extends Component {
    constructor() {
        super();

        this.state = {
            userId: "",
            otherId: "",
            password: "",
            username: "",
            userschool: "",
            usersignature: "",
            useravatar: "",
            usersex: "",
            userbirthday: "",
            followedList: [],
            fansList: [],
            collectGroup: [],
            collectgroupid: "",
            collectGroupName: "",
            collectdisplaystatus: "",
            collectpostnumber: "0",
            currenttime: "",
            Visible1: "",
            usersextrue: "",
            privatevisible: false,
            mypost: [],
            privatebasicColumns: [["私密", "公开"]],
            tabs: [{ key: 'message', title: '我的消息', icon: (active: boolean) => active ? <MessageFill /> : <MessageOutline />, badge: 0, },],
        }
    }
    componentDidMount() {
        $axios.post('/user/info/view', {
            "uid": this.props.location.state.userId,
        }).then(res => {
            console.log(res)
            this.setState({
                currenttime: new Date().toLocaleTimeString(),//获取当前时间
                password: res.data.user_password,
                username: res.data.user_name,
                userschool: res.data.school_name,
                usersignature: res.data.user_signature,
                useravatar: res.data.user_avatar,
                userbirthday: res.data.user_birthday,
                usersex: res.data.user_sex,

            })
        })
        if (this.state.usersex == 0) {
            this.setState({ usersextrue: "男", })
        } else if (this.state.usersex == 1) {
            this.setState({ usersextrue: "女", })
        }

        $axios.post('/user/interaction/followers', {
            "user_id": this.props.location.state.userId,
        }).then(res => {
            this.setState({
                fansList: res.data,
            })
        })
        $axios.post('/user/interaction/view_attention', {
            "user_id": this.props.location.state.userId,
        }).then(res => {
            console.log(res)
            this.setState({
                followedList: res.data,
            })
        })
        $axios.post('/user/favorites/view_list', {
            "user_id": this.props.location.state.userId,
            "collect_group_id": this.state.collectgroupid,



        }).then(res => {
            console.log(res)
            this.setState({
                collectGroup: res.data,

            })
        })
        $axios.post('/user/post/view_history', {
            "user_id": this.props.location.state.userId,
        }).then(res => {
            console.log(res)
            this.setState({
                mypost: res.data

            })
        })
    }

    //跳转到其他人的主页
    goinfo(uid) {
        this.props.history.push({ pathname: '/otherinfo', state: { otherId: uid } })
    }

    //跳转到收藏界面
    getcollect(collectgroupid,userId) {
        Toast.show({
            content: "跳转中",
            afterClose: () => {
                this.props.history.push({ pathname: '/collect', state: { collectgroupid: collectgroupid, userId:userId } })
            },
        })

    }

    updateinfo() {
        Toast.show({
            content: "跳转中",
            afterClose: () => {
                this.props.history.push({ pathname: '/infoupdate', state: { userId: this.props.location.state.userId } })
            },
        })

    }
    createcollectgroup() {
        $axios.post('/user/favorites/create_folder', {
            "user_id": this.props.location.state.userId,

            "collect_group_id": this.state.collectGroup.length + 1,
            "display_status": this.state.collectdisplaystatus,
            "post_number": 0,
            "collect_group_name": this.state.collectGroupName,
        }).then(res => {
            console.log(res)
            this.setState({
                Visible1: false,
            })
        })
    }
    render() {
        return (
            <div className="P-home">
                 <NavBar right={<div style={{ fontSize: 18 }}>
            
                </div>} onBack={() => {this.props.history.go(-1)}}>
                    个人信息
                </NavBar>

                    <Space direction='vertical'>
                        <h2>
                            <div style={{ fontWeight: 'normal' }}>
                                <Space>
                                    <Image
                                        src={this.state.useravatar}
                                        width={48}
                                        height={48}
                                        fit='cover'
                                        style={{ borderRadius: 32 }}//确定图像为圆形
                                    />
                                    {this.state.username}

                                    <right>
                                    </right>
                                    <Space wrap style={{ fontSize: 36 }}>
                                        <EditSOutline onClick={() => this.updateinfo()} />
                                    </Space>

                                </Space>
                                <h3>
                                    <h4>
                                        <Space>
                                            <h3>{this.state.userschool}</h3>
                                            <h3>{this.state.usersex == 1 ? "男" : "女"}</h3>
                                            <h3>{this.state.userbirthday}</h3>
                                        </Space>
                                    </h4>
                                    <signature>个性签名</signature>
                                    <br />
                                    <h3>{this.state.usersignature}</h3>
                                </h3>
                            </div>
                        </h2>
                    </Space>
                

                <JumboTabs>
                    <JumboTabs.Tab title={<Space direction='vertical'><HeartOutline />粉丝</Space>} key='fruits' >
                        <List>
                            {this.state.fansList.map(fansList => (
                                console.log(fansList),
                                <List.Item
                                    onClick={() => this.goinfo(fansList.user_id)}
                                    key={fansList.user_id}
                                    prefix={
                                        <Image
                                            src={fansList.user_avatar}
                                            style={{ borderRadius: 20 }}
                                            fit='cover'
                                            width={40}
                                            height={40}
                                        />
                                    }
                                    description={<h5>{fansList.user_signature}</h5>}
                                >
                                    <space>
                                        {fansList.user_name}
                                        <signature> {fansList.school_name}</signature>

                                    </space>

                                </List.Item>
                            ))}
                        </List>

                    </JumboTabs.Tab>
                    <JumboTabs.Tab title={<Space direction='vertical'><SmileOutline />关注</Space>} key='vegetables'>
                        <List>
                            {this.state.followedList.map(followedList => (
                                <List.Item
                                    onClick={() => this.goinfo(followedList.user_id)}
                                    key={followedList.user_name}
                                    prefix={
                                        <Image
                                            src={followedList.user_avatar}
                                            style={{ borderRadius: 20 }}
                                            fit='cover'
                                            width={40}
                                            height={40}
                                        />
                                    }
                                    description={<h5>{followedList.user_signature}</h5>}>
                                    <space>{followedList.user_name}
                                        <signature>{followedList.school_name}</signature></space>


                                </List.Item>
                            ))}
                        </List>

                    </JumboTabs.Tab>
                    <JumboTabs.Tab title={<Space direction='vertical'><StarOutline />收藏</Space>} key='animals'>
                        <List>
                            {this.state.collectGroup.map(collectGroup => (
                                <List.Item
                                    onClick={() => this.setState({ collectgroupid: collectGroup.collect_group_id })}
                                    onClick={() => this.getcollect(collectGroup.collect_group_id, collectGroup.userId)}
                                    key={collectGroup.collect_group_name}

                                    description={
                                        <h3>共{collectGroup.post_number}个内容</h3>
                                    } >
                                    <Space>
                                        {collectGroup.collect_group_name}
                                        <signature>{collectGroup.display_status == 1 ? "公开" : "私密"} </signature>
                                    </Space>

                                </List.Item>
                            ))}

                            <Button
                                size='large'
                                block
                                onClick={() => this.setState({ Visible1: true })}
                            >
                                新建收藏夹</Button>
                            <Popup
                                visible={this.state.Visible1}
                                onMaskClick={() =>
                                    this.setState({ Visible1: false })}
                                bodyStyle={{ minHeight: '40vh' }}>
                                <List style={{ '--prefix-width': '6em', }}>
                                    <List.Item title='收藏夹名称'>
                                        <Input clearable onChange={val => { this.setState({ collectGroupName: val }) }} />
                                    </List.Item>
                                    <List.Item title='访问权限' onClick={() => {
                                        this.setState({ privatevisible: true })
                                    }}>
                                        <Space direction='vertical'>

                                            <Picker
                                                columns={this.state.privatebasicColumns}
                                                visible={this.state.privatevisible}
                                                onClose={() => {
                                                    this.setState({ privatevisible: false })
                                                }}
                                                // value={this.state.usersex}
                                                onConfirm={v => {
                                                    { this.setState({ collectdisplaystatus: v == "私密" ? 0 : 1 }) }

                                                }}
                                            />
                                        </Space>
                                        {/* <Input clearable onChange={val => { this.setState({ collectdisplaystatus: val }) }} /> */}
                                    </List.Item>
                                </List>
                                <Button block onClick={() => this.createcollectgroup()} size='large'>
                                    新建收藏夹
                                </Button>
                            </Popup>

                        </List>

                    </JumboTabs.Tab>
                    <JumboTabs.Tab title={<Space direction='vertical'><HeartOutline />我的</Space>} key='myinfo'>
                        <List>
                            {this.state.mypost.map(mypost => (
                                <List.Item
                                    title={mypost.post_time}
                                >
                                    <Space direction='vertical' onClick={()=>{this.props.history.push({pathname:"/load_post",state})}}>
                                        {mypost.post_title}
                                        {/* <Space wrap>

                                            <Badge content={mypost.post_like_number}>
                                                <LikeOutline fontSize={24} />
                                            </Badge>
                                            <Badge content={mypost.comment_number}>
                                                <MessageOutline fontSize={24} />
                                            </Badge>
                                            <Badge content={mypost.collect_number}>
                                                <StarOutline fontSize={24} />

                                            </Badge>
                                        </Space> */}
                                    </Space>


                                </List.Item>
                            ))}
                        </List>

                    </JumboTabs.Tab>
                </JumboTabs>
            </div>
        )
    }
}
export default Info