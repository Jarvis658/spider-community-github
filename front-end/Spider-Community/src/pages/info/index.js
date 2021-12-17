import React, { Component, Fragment, FC, useState, useRef } from 'react'
import './info.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import { Picker, Empty, JumboTabs, NavBar, Radio, Badge, TabBar, Input, List, Space, Collapse, Card, Image, Toast, Button, Divider, Popup, ActionSheet } from 'antd-mobile'
import { UnorderedListOutline, PayCircleOutline, SetOutline, MessageOutline, MessageFill, AppOutline, UserOutline, } from 'antd-mobile-icons'

import { FileOutline, SmileOutline, HeartOutline, StarOutline,} from 'antd-mobile-icons'
import { removeLocalToken } from '../../common/request/token'


class Info extends Component {
    constructor() {
        super();

        this.state = {
            userId: "",
            otherId: "",
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
            Visible1: "",
            usersextrue: "",
            privatevisible: false,
            mypost: [],
            privatebasicColumns: [["私密", "公开"]],
            tabs: [{ key: 'message', title: '我的消息', icon: (active: boolean) => active ? <MessageFill /> : <MessageOutline />, badge: 0, },],
            visible_more:false
        }
    }

    componentWillMount() {
        $axios.post('/user/info/view', {
            "uid": this.props.location.state.userId,
        }).then(res => {
            this.setState({
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
        this.props.history.push({ pathname: '/otherinfo', state: { otherId: uid, userId: this.props.location.state.userId }})
    }

    //跳转到收藏界面
    getcollect(collectgroupid,userId, collectGroupName) {
        Toast.show({
            content: "跳转中",
            duration:100,
            afterClose: () => {
                this.props.history.push({ pathname: '/collect', state: { collectgroupid: collectgroupid, userId:userId ,collectGroupName:collectGroupName} })
            },
        })
    }

    updateinfo() {
        Toast.show({
            content: "跳转中",
            duration:100,
            afterClose: () => {
                this.props.history.push({ pathname: '/infoupdate', state: { userId: this.props.location.state.userId } })
            },
        })
    }

    createcollectgroup() {
        if(this.state.collectGroupName!=""){
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
        }else{
            Toast.show({
                content: '收藏夹名称不能为空！',
            })
        }
    }

    logout(){
        removeLocalToken()
        const InspireCloud = require ('@byteinspire/js-sdk')
        const serviceId = 'qcdy4y'; // 替换成你的 serviceId
        const inspirecloud = new InspireCloud({ serviceId });
        
        // 调用名为 logout 的云函数，若未登录，则无法修改
        inspirecloud.run('logout', {}).then(res => {
        console.log(res);
        });
        Toast.show({
            content: "成功退出！",
            duration:1000,
            afterClose: () => {
                this.props.history.push({ pathname: '/login'}) 
            },
        })
    }

    render() {
        console.log(this.state.username)
        const more_operation = [
            { text: '编辑资料', 
              key: 'edit',
              onClick:() => this.updateinfo()
            },
            { text: '退出登录', 
              key: 'report',
              onClick: ()=>{this.logout()}
            },
        ]
        return (
            <div className="P-home">
                <ActionSheet
                        extra='请选择你要进行的操作'
                        cancelText='取消'
                        visible={this.state.visible_more}
                        actions={more_operation}
                        onClose={() => this.setState({visible_more:false})}
                    />
                <NavBar right={<div style={{ fontSize: 18 }}></div>} onBack={() => {this.props.history.push({pathname:"/home", state:{userId: this.props.location.state.userId}})}}>
                    <div className='myinfo-nav'>
                        <div className='myinfo-nav-info'>个人信息</div>
                        <div><img src="https://img.icons8.com/material-outlined/25/000000/more.png" onClick={()=>{this.setState({visible_more:true})}}/></div>
                    </div>
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
                            

                            </Space>
                            <h3>
                                <Space>
                                    <h3>{this.state.userschool}</h3>
                                    <h3>{this.state.usersex == 1 ? "男" : "女"}</h3>
                                    <h3>{this.state.userbirthday}</h3>
                                </Space>
                                <h3>个性签名:</h3>
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
                                    onClick={() => this.getcollect(collectGroup.collect_group_id, collectGroup.userId, collectGroup.collect_group_name)}
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
                                        {this.state.collectdisplaystatus == 1 ? "公开" : "私密"}
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
                    <JumboTabs.Tab title={<Space direction='vertical'><FileOutline />文章</Space>} key='myinfo'>
                        <List>
                            {this.state.mypost.map(mypost => (
                                <List.Item title={mypost.post_time}  onClick={()=>{this.props.history.push({pathname:"/load_post",state:{userId:this.props.location.state.userId,postId:mypost.post_id}})}}>
                                    <Space direction='vertical'>
                                        {mypost.post_title}
                                    </Space>
                                </List.Item>
                            ))}
                        </List>
                    </JumboTabs.Tab>

                    <JumboTabs.Tab title={
                        <Space direction='vertical' onClick={()=>{this.props.history.push({pathname:"/news",state:{userId: this.props.location.state.userId,useravatar:this.state.useravatar}})}}>
                            <MessageOutline />互动
                        </Space>} key='interaction'>
                    </JumboTabs.Tab>
                </JumboTabs>
            </div>
        )
    }
}
export default Info