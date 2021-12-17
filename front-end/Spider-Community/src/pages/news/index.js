import React, { Component, Fragment, useState, useRef } from 'react'
import './info.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import { Badge, TabBar,Empty ,JumboTabs,DatePicker, Selector, Slider, Stepper, TextArea, Form, Input, List, Space, Collapse, Card, Image, Toast, Button, Divider, Popup, Dialog } from 'antd-mobile'
import { AntOutline, RightOutline, ExclamationCircleFill, AppOutline,   MessageOutline,   MessageFill,   UnorderedListOutline,   UserOutline, } from 'antd-mobile-icons'

class News extends Component {
    constructor() {
        super();
        this.state = {
            userId: "",
            password: "",
            postlike:[],  
            postcomment:[],    
        }
    }

    componentDidMount() {
        this.setState({userId:this.props.location.state.userId})
        $axios.post('/user/interaction/view_like', {
            "user_id": this.props.location.state.userId,
        }).then(res => {
            console.log(res)
            this.setState({
               postlike:res.data
            })
        })

        $axios.post('/user/interaction/view_comment', {
            "user_id": this.props.location.state.userId,
        }).then(res => {
            console.log(res)
            this.setState({
               postcomment:res.data
            })
        })
    }
   
    render() {
        return (
            <div className="P-home">
                <img src="https://img.icons8.com/fluent-systems-regular/18/000000/back.png" onClick={()=>this.props.history.go(-1)} />
                <JumboTabs>
                <JumboTabs.Tab title='点赞'  key='fruits'>
                    <List>
                        {this.state.postlike.map(postlike => (
                        <List.Item
                            key={postlike.post_like_id}
                                description={<h3>{postlike.like_time}</h3>} >
                                <space>
                                    您给文章“{postlike.post_title}”点了赞     
                                </space>
                        </List.Item>
                            ))}
                    </List>
                </JumboTabs.Tab>
                <JumboTabs.Tab title='评论'  key='vegetables'>
                             <List>
                            {this.state.postcomment.map(postcomment => (
                                <List.Item
                                    key={postcomment.comment_id}
                                    description={<space>{postcomment.comment_content}
                                    
                                    <h3>{postcomment.comment_time}</h3>
                                    </space>} >
                                   
                                        您评论了文章“{postcomment.post_title}”，

                                        
                                    

                                </List.Item>
                            ))}
                        </List>
            
          </JumboTabs.Tab>
        
        </JumboTabs>                   
            </div>
        )
    }
}
export default News