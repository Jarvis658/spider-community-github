import React, { Component,ComponentType, Fragment, useState, useRef } from 'react'
import './collect.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import * as Icons from 'antd-mobile-icons'
import { Input, List, Space, Collapse,NavBar, Card, Image, Toast, Button, Divider, Popup, Dialog,Grid } from 'antd-mobile'
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
            userId: "100",
            collectgroupid:"",

            password: "",
            username: "",
            userschool: "",
            usersignature: "",
            useravatar: "",
            usersex: "",
            userbirthday: "",
            followedList: [],
            fansList: [],
            collect:[],
            postid:"",

            editvisibile:"",
            collectGroupName: "",
            collectdisplaystatus: "",
        }
    }
    componentDidMount() {
        $axios.post('/user/favorites/view_content', {
            "collect_group_id":this.props.location.state.collectgroupid
        }).then(res => {
            console.log(res)
            this.setState({
                collect: res.data,
            })
        })
    }
    deleteCollectGroup(){
        $axios.post('/user/favorites/delete_folder', {
            "collect_group_id":this.props.location.state.collectgroupid
        }).then(res=>{
            this.props.history.push({ pathname: '/info' })
        })
        this.props.history.push({ pathname: '/info' })
    }
    collectstatus(postid){
        this.setState({postid:postid})
        $axios.post('/user/favorites/delete_post', {
            // "user_id": this.state.userId,
            "collect_group_id":this.props.location.state.collectgroupid,
            "post_id":postid,
        }).then(res => {
            console.log(res)
            this.setState({
               

            })
        })
        
    }
    updatecollect(){
        this.setState({editvisibile : true })

        $axios.post('/user/favorites/edit_folder', {
            // "user_id": this.state.userId,
            "collect_group_id":this.props.location.state.collectgroupid,
            "collect_group_name":this.state.collectGroupName,
            "display_status":this.state.collectdisplaystatus,


        }).then(res => {
            console.log(res)
            this.setState({
            })
        })
    }
    render() {
        return (
            <div className="P-home">
                <NavBar right={<div style={{ fontSize: 18 }}>
            
            </div>} onBack={() => {this.props.history.go(-1)}}>
                收藏夹
            </NavBar>
                  <List>
                            {this.state.collect.map(collect => (
                                <List.Item key={collect.post_id} onClick={()=>{this.props.history.push({pathname:'/load_post',state:{postId:collect.post_id,userId:this.props.location.state.userId}})}}>                             
                                    <space>{collect.post_title} 
                                    </space>
                                </List.Item>
                            ))}
                        </List>
                        

                


                


               <Space>
               <Button  fill='outline' onClick={() => this.deleteCollectGroup()}>删除收藏夹 </Button>
                <Button  fill='outline' onClick={() =>this.setState({editvisibile : true })}>编辑收藏夹 </Button>

               </Space>
                
                <Popup
                                visible={this.state.editvisibile}
                                onMaskClick={() =>
                                this.setState({ editvisibile: false })}
                                bodyStyle={{ minHeight: '40vh' }}>
                                <List style={{ '--prefix-width': '6em', }}>
                                    <List.Item title='收藏夹名称'>
                                        <Input clearable onChange={val => { this.setState({ collectGroupName: val }) }} />
                                    </List.Item>
                                    <List.Item title='私密'>
                                        <Input clearable onChange={val => { this.setState({ collectdisplaystatus: val }) }} />
                                    </List.Item>
                                </List>
                                <Button block onClick={() => this.updatecollect()} size='large'>
                                    确定修改
                              </Button>
                            </Popup>
                          
                {this.state.postid}
            </div>
        )
    }





}
export default Collect