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


class OtherCollect extends Component {
    constructor() {

        super();
        this.state = {
            userId: "",
            collectgroupid: "",

            password: "",
            username: "",
            userschool: "",
            usersignature: "",
            useravatar: "",
            usersex: "",
            userbirthday: "",
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
            console.log(res)
            this.setState({
                collect: res.data,
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
        this.setState({ postid: postid })
        $axios.post('/user/favorites/delete_post', {
            // "user_id": this.state.userId,
            "collect_group_id": this.props.location.state.collectgroupid,
            "post_id": postid,
        }).then(res => {
            console.log(res)
            this.setState({


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
 
    // star(postId){
    //     return (<StarOutline onClick={() => this.collectstatus.bind(this,postId)}/>)

    // }

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
                              
                               <div
                                 onClick={()=>{this.props.history.push({pathname:'/load_post',state:{postId:collect.post_id,userId:this.props.location.state.userId}})}}
                               >{collect.post_title}</div>
                             </Space>  
                           
                        </List.Item>
                    ))}
                </List>

            

             
            </div>
        )
    }





}
export default OtherCollect