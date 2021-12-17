import React, { Component, ComponentType, Fragment, useState, useRef } from 'react'
import './collect.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import * as Icons from 'antd-mobile-icons'
import {  Picker,Input, List, Space, Collapse, NavBar, Card, Image, Toast, Button, Divider, Popup, Dialog, Grid } from 'antd-mobile'
import {
    UnorderedListOutline,
    PayCircleOutline,
    SetOutline,
    ArrowDownCircleOutline,
    StarOutline
} from 'antd-mobile-icons'


import { sleep } from '../../common/request'
import { AntOutline, RightOutline, ExclamationCircleFill } from 'antd-mobile-icons'
import styles from './index.less'
import { DialogShowRef } from 'antd-mobile/es/components/dialog'


class Collect extends Component {
    constructor() {

        super();
        this.state = {
            userId: "",
            collectgroupid: "",
            followedList: [],
            fansList: [],
            collect: [],
            postid: "",
            privatevisible:false,
            editvisibile: "",
            collectGroupName: "",
            collectdisplaystatus: "",
            privatebasicColumns:[["私密","公开"]],
        }
    }
    componentDidMount() {
        $axios.post('/user/favorites/view_content', {
            "collect_group_id": this.props.location.state.collectgroupid
        }).then(res => {
            this.setState({
                collect: res.data,
                collectGroupName: this.props.location.state.collectGroupName
            })
        })
    }

    deleteCollectGroup() {
        $axios.post('/user/favorites/delete_folder', {
            "collect_group_id": this.props.location.state.collectgroupid
        }).then(res => {
            this.props.history.go(-1)
        })
    }

    collectstatus(postid) {
        // this.setState({ postid: postid })
        $axios.post('/user/favorites/delete_post', {
            "collect_group_id": this.props.location.state.collectgroupid,
            "post_id": postid,
        }).then(res => {
            Toast.show({
                content: "已删除",
                duration:100,
                afterClose: () => {
                    window.location.reload()
                },
            })
            
        })

    }
    updatecollect() {
        if(this.state.collectGroupName!=""){
        this.setState({ editvisibile: true })

        $axios.post('/user/favorites/edit_folder', {
            // "user_id": this.state.userId,
            "collect_group_id": this.props.location.state.collectgroupid,
            "collect_group_name": this.state.collectGroupName,
            "display_status": this.state.collectdisplaystatus,


        }).then(res => {
            console.log(res)
            this.setState({
            })
        })
    }else{
        Toast.show({
            content: '收藏夹名称不能为空！',
        })
    }
    }


    render() {
        let buttongroup = (<Button  fill='outline' onClick={() => this.deleteCollectGroup()}>删除收藏夹 </Button>  )
        return (
            <div className="P-home">
                <NavBar right={<div style={{ fontSize: 18 }}>
            
                </div>} onBack={() => { this.props.history.go(-1) }}>
                    收藏夹
            </NavBar>
                <List>
                
                    {this.state.collect.map(collect => (
                        <List.Item key={collect.post_id} 
                        
                        >                             
                           <Space>
                                {/* {this.star(collect.post_id)} */}
                               <StarOutline onClick={() => this.collectstatus(collect.post_id)}/>
                               <div
                                 onClick={()=>{this.props.history.push({pathname:'/load_post',state:{postId:collect.post_id,userId:this.props.location.state.userId}})}}
                               >{collect.post_title}</div>
                             </Space>  
                           
                        </List.Item>
                    ))}
                </List>

                <Space>
                   {buttongroup}
                    <Button fill='outline' onClick={() => this.setState({ editvisibile: true })}>编辑收藏夹 </Button>

                </Space>

                <Popup
                    visible={this.state.editvisibile}
                    onMaskClick={() =>
                        this.setState({ editvisibile: false })}
                    bodyStyle={{ minHeight: '40vh' }}>
                    <List style={{ '--prefix-width': '6em', }}>
                        <List.Item title='收藏夹名称'>
                            <Input placeholder={this.state.collectGroupName} clearable onChange={val => { this.setState({ collectGroupName: val }) }} />
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
                          
                        </List.Item>
                    </List>
                    <Button block onClick={() => this.updatecollect()} size='large'>
                        确定修改
                              </Button>
                </Popup>

             
            </div>
        )
    }





}
export default Collect