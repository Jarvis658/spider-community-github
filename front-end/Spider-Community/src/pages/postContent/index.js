import React, { Component} from 'react'
import './postContent.sass'
import $axios from '../../common/request'
import { Image, Toast, Tag, Button, Divider, Popup, Dialog, ActionSheet, NavBar} from 'antd-mobile'
import { StarOutline } from 'antd-mobile-icons';



class PostContent extends Component {
    constructor(){
        super()
        this.state = {
            post:null,
            commentList:[],
            follow_status:null,
            like_status:null,
            collect_status:null,
            collect_number:null,
            visible_collect_group:false,
            visible_other:false,
            visible_report:false,
            collectList:[],
            post_like_number:null,
            post_comment_number:null,
            collect_group_status:{},
            collect_group_post_number:{},
            comment_like_number:{},
            comment_like_status:{},
            report_status:null,
            
        }
    }


    componentDidMount() {
        const userId = this.props.location.state.userId
        const postId = this.props.location.state.postId
        $axios.post('/user/load_post/loadPost', {
            "uid":userId,
            "pno":postId
        }).then(res => {
            console.log(res.data)
            this.setState({
                post:res.data,
                follow_status:res.data.follow_status,
                like_status:res.data.like_status,
                collect_status:res.data.collect_status,
                post_like_number:res.data.post_like_number,
                collect_number:res.data.collect_number,
                post_comment_number:res.data.comment_number,
                report_status:res.data.report_status
            })
        })

        $axios.post('/user/load_post/loadComment', {
            "uid":userId,
            "pno":postId
        }).then(res => {
            let obj1 = {}
            let obj2 = {}
            res.data.map(comment=>{
                obj1[comment[0].comment_id] = comment[0].like_status
                obj2[comment[0].comment_id] = comment[0].comment_like_number
            })
            this.setState({
                commentList:res.data,
                comment_like_status:obj1,
                comment_like_number:obj2, 
            }) 
        })

        $axios.post('/user/interaction/loadCollectGroups', {
            "uid":userId,
            "pno":postId
        }).then(res => {
            let obj1 = {}
            let obj2 = {}
            res.data.map(collect=>{
                obj1[collect.collect_group_id] = collect.collect_status
                obj2[collect.collect_group_id] = collect.post_number
            })
            this.setState({
                collectList:res.data,
                collect_group_status:obj1,
                collect_group_post_number:obj2, 
            })
        })
    }

    attention(myUid, otherUid) {
        $axios.post('/user/interaction/attention', {
            "myUid":myUid,
            "otherUid":otherUid
        }).then(res => {
                if(this.state.follow_status == 1) {
                    this.setState({
                        follow_status:0
                    })
                }
                else if(this.state.follow_status == 0) {
                    this.setState({
                        follow_status:1
                    })
                }   
            })
    }

    post_like(userId, postId) {
        $axios.post('/user/interaction/like_post', {
            "uid":userId,
            "pno":postId
        }).then(res => {
                if(this.state.like_status == 1) {
                    this.setState({
                        like_status:0,
                        post_like_number:this.state.post_like_number-1
                    })
                }
                else if(this.state.like_status == 0) {
                    this.setState({
                        like_status:1,
                        post_like_number:this.state.post_like_number+1
                    })
                }   
            })
    }

    collect(collectStatus,collectGroupId,userId,postId) {
        $axios.post('/user/interaction/collect', {
            "uid":userId,
            "pno":postId,
            "collectGroupId":collectGroupId
        }).then(res => { 
            if(collectStatus == 1){
                let obj1 = {}
                let obj2 = {}
                obj1[collectGroupId] = 0
                obj2[collectGroupId] = this.state.collect_group_post_number[collectGroupId] - 1
                let data1 = Object.assign({}, this.state.collect_group_status, obj1)
                let data2 = Object.assign({}, this.state.collect_group_post_number, obj2)
                this.setState({
                    collect_number:this.state.collect_number-1,
                    collect_group_status:data1,
                    collect_group_post_number:data2,
                })
                Toast.show({
                    content: '已取消',
                    maskClickable: true,
                    position: 'bottom'
                  })
            }
            else {
                let obj1 = {}
                let obj2 = {}
                obj1[collectGroupId] = 1
                obj2[collectGroupId] = this.state.collect_group_post_number[collectGroupId] + 1
                let data1 = Object.assign({}, this.state.collect_group_status, obj1)
                let data2 = Object.assign({}, this.state.collect_group_post_number, obj2)
                this.setState({
                    collect_number:this.state.collect_number+1,
                    collect_group_status:data1,
                    collect_group_post_number:data2,
                })
                Toast.show({
                    content: '已收藏',
                    maskClickable: true,
                    position: 'bottom'
                  })
            }
            })
    }

    comment(userId,postId){
        if(this.input.value != "") {
            $axios.post('/user/interaction/comment', {
                "user_id":userId,
                "post_id":postId,
                "comment_content":this.input.value,
                "parent_comment_id":postId
            }).then(res => { 
                this.input.value = null
                Toast.show({icon: 'success', content: '发送成功',})
                this.setState({
                    post_comment_number:this.state.post_comment_number + 1
                })
                this.props.history.go(0)
                })
        }
	}

    collectButtonIf(collect_status,userId,postId,collectGroupId){
        if(this.state.collect_group_status[collectGroupId] == 1)
            return <Button className="input-button-collect" block shape='rounded' onClick={this.collect.bind(this,collect_status,collectGroupId,userId,postId)}>已收藏</Button>
        else
            return <Button color='primary' className="input-button-collect" block shape='rounded' onClick={this.collect.bind(this,collect_status,collectGroupId,userId,postId)}>收藏</Button>
    }

    reply(subCommentNumber, commentId){
        if(subCommentNumber > 1)
            return (<div className="reply" onClick={this.subComment.bind(this, commentId, this.props.location.state.postId)}>
                        查看全部{subCommentNumber}条回复
                    </div>)
        else
            return <div></div>
    }

    subComment(commentId, postId) {
        this.props.history.push({pathname:'/sub_comment', state:{userId:this.props.location.state.userId, commentId:commentId, postId:postId}})
    }

    comment_like(commentId, userId){
        $axios.post('/user/interaction/like_comment', {
            "uid":userId,
            "pno":commentId,
        }).then(res => {
            if(this.state.comment_like_status[commentId] == 1){
                let obj1 = {}
                let obj2 = {}
                obj1[commentId] = 0
                obj2[commentId] = this.state.comment_like_number[commentId] - 1
                let data1 = Object.assign({}, this.state.comment_like_status, obj1)
                let data2 = Object.assign({}, this.state.comment_like_number, obj2)
                this.setState({
                    comment_like_status:data1,
                    comment_like_number:data2,
                })}
            else {
                let obj1 = {}
                let obj2 = {}
                obj1[commentId] = 1
                obj2[commentId] = this.state.comment_like_number[commentId] + 1
                let data1 = Object.assign({}, this.state.comment_like_status, obj1)
                let data2 = Object.assign({}, this.state.comment_like_number, obj2)
                this.setState({
                    comment_like_status:data1,
                    comment_like_number:data2,
                })}
         })

    }

    commentLikeIf(commentId) {
        if(this.state.comment_like_status[commentId] == 1)
            return (<img onClick={this.comment_like.bind(this,commentId, this.props.location.state.userId)} src="https://img.icons8.com/dusk/17/000000/facebook-like.png"/>)
        else
            return (<img onClick={this.comment_like.bind(this,commentId, this.props.location.state.userId)} src="https://img.icons8.com/wired/17/000000/facebook-like.png"/>)
    }

    deleteButton(hostId, commentId) {
        if(hostId == this.props.location.state.userId)
            return <img onClick={this.deleteComment.bind(this,this.props.location.state.postId, commentId)} src="https://img.icons8.com/ios/17/000000/delete--v1.png"/>
        else
            return
    }

    deleteComment(postId, commentId) {
        Dialog.confirm({
            content: '是否删除该条评论',
            onConfirm:() => {
                $axios.post("/user/interaction/delete_comment",{
                    post_id:postId,
                    comment_id:commentId
                })
              Toast.show({
                icon: 'success',
                content: '删除成功',
                position: 'center',
              })
              this.props.history.go(0)

            },
          })
    }

    report(){
        if(this.state.report_status == 1){
            Toast.show({
                content: '您已举报，管理员审核中！',
                maskClickable: false,
                position: 'center'
              })
        }
        else{
            $axios.post("/user/post/report",{
                post_id:this.props.location.state.postId,
                user_id:this.props.location.state.userId
            }).then(()=>{
                Toast.show({
                    content: '举报成功！',
                    maskClickable: false,
                    position: 'center',
                    afterClose: () => {
                        this.setState({
                            report_status: 1
                        })
                    },
                  })
                
            })
        }
    }

    render() {
        console.log(this.state.post)
        const userId = this.props.location.state.userId
        const postId = this.props.location.state.postId

        const user_actions_author = [
            { text: '再编辑文章', 
              key: 're-edit',
              onClick: ()=>{this.props.history.push({pathname:'/post', state:{userId: this.props.location.state.userId, postId: this.props.location.state.postId}})}  
            },
            { text: '分享', 
              key: 'share',
              },
            { text: '删除文章',
              key: 'delete',
              onClick: async () => {
                const result = await Dialog.confirm({ content: '确定要删除吗？' })
                if (result) {
                    $axios.post('/user/post/delete', {
                        "post_id": this.props.location.state.postId,
                    }).then(res => {
                        this.props.history.push({pathname: '/home', state:{userId:this.props.location.state.userId}})
                    })
                }
              }
            },
          ]
        const user_actions_others = [
            { text: '分享', key: 'share' },
            { text: '举报文章', 
              key: 'report',
              onClick: ()=>{this.report()}
            },
        ]
        
        if(this.state.post == null)
            return(<div></div>)
        
        if(this.state.post.author_role == 1)
            return(
                <div className="all">
                    <Popup visible={this.state.visible_report}
                        position='right'
                        bodyStyle={{ minWidth: '100%' }}>
                            <NavBar onBack={()=>{this.setState({visible_report:false})}}>举报</NavBar>
                    </Popup>
                    <div className="header-loadpost">
                        <div><img src="https://img.icons8.com/fluent-systems-regular/18/000000/back.png" onClick={()=>this.props.history.go(-1)} /></div>
                        <div className="user-avatar" onClick={() => {this.props.history.push({pathname:'/otherinfo', state:{otherId:this.state.post.user_id}})}}>
                            <Image src={this.state.post.user_avatar} width={44} height={44} fit='cover' style={{ borderRadius: 25 }}/></div>
                        <div className="user-name">{this.state.post.user_name}</div>
                        <Tag color='primary' fill='outline' style={{ '--border-radius': '6px',height:20 ,marginTop:15}}>管理员</Tag>
                        <Divider />
                    </div>
                    <div className="content-post">
                        <div style={{fontSize:17}}>
                            <Divider />
                                {this.state.post.post_title}
                            <Divider />
                        </div>
                        <span dangerouslySetInnerHTML={{__html: this.state.post.post_content}} className="richText"></span>
                    </div>
                </div>
            )

        let followButton = null
        let postLikeButton = null
        let collectButton = null
        let actionSheet = null

        if(this.state.follow_status == 1)
            followButton = (<Button size='small' shape='rounded' onClick={this.attention.bind(this, userId, this.state.post.user_id)}>已关注</Button>)
        if(this.state.follow_status == 0)
            followButton = (<Button size='small' color='primary' shape='rounded' onClick={this.attention.bind(this, userId, this.state.post.user_id)}>关注</Button>)
        if(this.state.post.user_id == this.props.location.state.userId)
            followButton = (<div></div>)

        if(this.state.collect_number > 0)
            collectButton = (<img src="https://img.icons8.com/office/25/000000/add-to-favorites.png" onClick={()=>{this.setState({visible_collect_group:true})}}/>)
        if(this.state.collect_number == 0)
            collectButton = (<img src="https://img.icons8.com/ios/25/000000/add-to-favorites--v1.png" onClick={()=>{this.setState({visible_collect_group:true})}}/>)

        if(this.state.like_status == 0)
            postLikeButton = (<img src="https://img.icons8.com/wired/25/000000/facebook-like.png" onClick={this.post_like.bind(this, userId, this.state.post.post_id)}/>)
        if(this.state.like_status == 1)
            postLikeButton = (<img src="https://img.icons8.com/dusk/25/000000/facebook-like.png" onClick={this.post_like.bind(this, userId, this.state.post.post_id)}/>)

        if(this.state.post.user_id == this.props.location.state.userId)
            actionSheet = user_actions_author
        if(this.state.post.user_id != this.props.location.state.userId)
            actionSheet = user_actions_others
          

        let comment = (
            <div>
                {this.state.commentList.map(oneComment=>
                    <div> 
                        <div className="oneCommentBlock">
                            <div className="one-two-img">
                                <Image src={oneComment[0].user_avatar} width={35} height={35} fit='cover' style={{ borderRadius: 25 }} onClick={()=>this.props.history.push({pathname:"/info", state:{userId: oneComment[0].user_id}})}/>
                            </div>
                            <div className="right">
                                <div className="comment-name">{oneComment[0].user_name}</div>
                                <div className="content-comment">{oneComment[0].comment_content}</div>
                                <div className="comment-time">
                                    <div className="one-comment-time">{oneComment[0].comment_time}</div>
                                    <div className="one-comment-like">{this.commentLikeIf(oneComment[0].comment_id)}  {this.state.comment_like_number[oneComment[0].comment_id]}</div>
                                    <div className="comment-comment"><img onClick={this.subComment.bind(this, oneComment[0].comment_id, postId)} src="https://img.icons8.com/fluency-systems-regular/17/000000/comments--v1.png"/> {oneComment[0].sub_comment_number}</div>
                                    <div className="comment-delete-button">{this.deleteButton(oneComment[0].user_id, oneComment[0].comment_id)}</div>
                                </div>
                                {oneComment[1].map((twoComment, index)=>{
                                    if(index == 0)
                                        return (
                                            <div className="twoCommentBlock">
                                                <div className="one-two-img">
                                                    <Image src={twoComment.user_avatar} width={35} height={35} fit='cover' style={{ borderRadius: 25 }} onClick={()=>this.props.history.push({pathname:"/info", state:{userId: twoComment.user_id}})}/>
                                                </div>
                                                <div className="right">
                                                    <div className="comment-name">{twoComment.user_name}</div>
                                                    <div className="content-comment">{twoComment.comment_content}</div>
                                                    <div className="comment-name">{twoComment.comment_time}</div>
                                                    <div>{this.reply(oneComment[0].sub_comment_number, oneComment[0].comment_id)}</div>
                                                </div>
                                            </div>)
                                    else
                                        return false
                                }
                                )}
                            </div>
                        </div>
                        <Divider />
                    </div>
                    )}
            </div>
        )

        let collectList = (
            <div style={{ height: '50vh', overflowY: 'scroll' }}>
                <div style={{fontSize: 20, marginTop: 15, marginLeft: 10}}>选择收藏夹</div>
                <Divider />
                {this.state.collectList.map(collect=>
                <div>
                    <p></p>
                    <p></p>
                    <div className="collect-one">
                        <div className="collect-two">
                            <div className="font-one">{collect.collect_group_name}</div> 
                            <div className="font-two">{this.state.collect_group_post_number[collect.collect_group_id]}个内容</div>   
                        </div>  
                        <div>{this.collectButtonIf(this.state.collect_group_status[collect.collect_group_id], userId, postId, collect.collect_group_id)}</div>    
                    </div>
                    <Divider />
                </div>
                )}
            </div>
        )
        
            
            return (
                <div className="all">
                    <Popup visible={this.state.visible_collect_group}
                        onMaskClick={() => {this.setState({visible_collect_group:false})}}
                        bodyStyle={{borderTopLeftRadius: '8px',borderTopRightRadius: '8px',minHeight: '50vh',
                        }}>
                        {collectList}
                    </Popup>

                    <Popup visible={this.state.visible_report}
                        position='right'
                        bodyStyle={{ minWidth: '100%' }}>
                            <NavBar onBack={()=>{this.setState({visible_report:false})}}>举报</NavBar>
                    </Popup>

                    <ActionSheet
                        extra='请选择你要进行的操作'
                        cancelText='取消'
                        visible={this.state.visible_other}
                        actions={actionSheet}
                        onClose={() => this.setState({visible_other:false})}
                    />

                    <div className="header-loadpost">
                        <div><img src="https://img.icons8.com/fluent-systems-regular/18/000000/back.png" onClick={()=>this.props.history.go(-1)} /></div>
                        <div className="user-avatar" onClick={() => {this.props.history.push({pathname:'/otherinfo', state:{otherId:this.state.post.user_id}})}}>
                            <Image src={this.state.post.user_avatar} width={44} height={44} fit='cover' style={{ borderRadius: 25 }}/></div>
                        <div className="user-name">{this.state.post.user_name}</div>
                        <div className="follow-button">{followButton}</div>
                        <div className="more-button"><img src="https://img.icons8.com/material-outlined/25/000000/more.png" onClick={()=>{this.setState({visible_other:true})}}/></div>
                        <Divider />
                    </div>
                    <div className="content-post">
                        <div style={{fontSize:17}}>
                            <Divider />
                                {this.state.post.post_title}
                            <Divider />
                        </div>
                        <span dangerouslySetInnerHTML={{__html: this.state.post.post_content}} className="richText"></span>
                        <Divider />
                        <div className="interaction">
                            <input className="input-comment-post" type="text" ref={input => this.input = input} placeholder="  发条友善的评论吧"/>
                            <Button className="input-button" onClick={this.comment.bind(this,userId,postId)} block shape='rounded' color='primary'>发送</Button>
                            <div className="post-like">
                                {postLikeButton}
                                <label className="interaction-number"> {this.state.post_like_number}</label>
                            </div>
                            <div className="post-collect">
                                {collectButton}
                                <label className="interaction-number"> {this.state.collect_number}</label>
                            </div>
                        </div>
                        <div className="comment-number">共{this.state.post_comment_number}条评论</div>
                        <Divider />
                        <div>{comment}</div>
                    </div>
                    <div>
                    </div>
                </div>
        )
    }


}

export default PostContent