import React from 'react'
// import InfiniteScroll from 'react-infinite-scroller'
import $axios from '../../common/request'
import './home.sass'
import { Tabs, NavBar, Card, Button, Toast, Space, Popup, SearchBar, Badge, TabBar } from 'antd-mobile'
import { SearchOutline, LeftOutline, HeartFill, HeartOutline, AppOutline, AddSquareOutline, UserOutline } from 'antd-mobile-icons'
import { BottomScrollListener } from 'react-bottom-scroll-listener'

class Home extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            hasMore: true, // 是否开启下拉加载
            data: [], // 接受我每次的数据
            loading: false,
            like_status: {},
            visible: false,
            activeKey: null,
        }
    }

    componentDidMount() {
        this.getPostsData()
    }

    getPostsData = async () => {
        console.log("rendering")
        const user_id = this.props.location.state.userId
        try {
            const res = await $axios.post('/user/tab/recommend', { "u_id": user_id })
            const posts = res.data
            const originData = this.state.data

            if (posts.length === 0) {
                this.handleOnDocumentBottom()
                return
            }

            this.setState({
                data: [...originData, ...posts]
            })

            console.log("this is new data", posts)

        } catch (error) {
            console.log(error)
        }
    }

    post_like(userId, postId) {
        $axios.post('/user/interaction/like_post', {
            "uid": userId,
            "pno": postId
        }).then(res => {
            if (this.state.like_status === 1) {
                console.log("goes to 1")
                this.setState({
                    like_status: 0,

                })
            }
            else if (this.state.like_status === 0) {
                console.log("goes to 0")
                this.setState({
                    like_status: 1,
                })
            }
        })
    }


    view_record(userId, postId) {
        $axios.post('/user/action/view', {
            'user_id': userId,
            'post_id': postId
        }).then(res => {
        })
    }

    make_card(post, count) {
        let postLikeButton = null
        var LR = null
        if (count % 2 === 0) { LR = "left" }
        if (count % 2 === 1) { LR = "right" }
        if (post.like_status === 0)
            postLikeButton = (
                <HeartOutline color="#707070" />
            )
        if (post.like_status === 1)
            postLikeButton = (
                <HeartFill color="#e45454" />
            )

        return (
            <div className="P-home">
                <div className="card" style={{ float: LR }} onClick={()=>{this.props.history.push({pathname:'/load_post', state:{postId:post.post_id, userId:this.props.location.state.userId}})}}>
                    <div className="post_id">{post.post_id}</div>
                    <Card style={{ padding: "3px" }}>
                        <div className="image" >
                            <img style={{ borderRadius: "2px", width: "100%" }} src={post.cover_image} />
                        </div>
                        <div className="sub">
                            <div className="title">
                                {post.post_title}
                            </div>
                            <div className="like">
                                <Space wrap style={{ fontSize: 20 }}>{postLikeButton}{post.post_like_number}</Space>
                            </div>
                            <div className="author">
                                <img src={post.user_avatar} width={15} height={15} fit='cover' style={{ borderRadius: 25 }} />
                                {post.user_name}
                            </div>
                        </div>
                    </Card>
                </div>
            </div>
        )
    }


    handleOnDocumentBottom = () => {
        console.log('I am at bottom! ' + Math.round(performance.now()));

        if (this.props.alertOnBottom) {
            alert('Bottom hit! Too slow? Reduce "debounce" value in props');
        }
    };

    make_posts = () => {
        var posts = []
        var currCard
        const user_id = this.props.location.state.userId
        var func = this.view_record
        for (let i = 0; i < this.state.data.length; i++) {
            currCard = <div>{this.make_card(this.state.data[i], i)}</div>
            posts.push(currCard)
        }

        var cards = document.querySelectorAll(".card")
        for (let i = 0; i < cards.length; i++) {

            var observer = new IntersectionObserver(
                function (entries) {
                    // 如果不可见，就返回
                    if (entries[0].intersectionRatio <= 0) return;

                    // console.log(entries, cards[i])
                    var post_id = cards[i].querySelector(".post_id").textContent
                    console.log("===============", post_id)
                    // func(user_id, post_id)
                    // this.view_record(user_id, cards[i].querySelector(".post_id").textContent)                        
                })
            observer.observe(cards[i])
        }
        return posts
    }

    callback(entries, card) {
        if (entries[0].intersectionRatio <= 0) return;
        console.log(entries)
        console.log("===============", card.querySelector(".post_id").textContent)
    }

    setVisible(boolean) {
        this.setState({ visible: boolean })
    }

    setActiveKey(input) {
        this.setState({ activeKey: input })
    }

    loadPost(postId, userId) {
        this.props.history.push({pathname:'/load_post', state:{postId:postId, userId:userId}})
    }

    toPost(userId){
        this.props.history.push({pathname:'/post', state:{userId:userId}})
    }

    render() {
        let Posts = this.make_posts()
        const right = (
            <div style={{ fontSize: 18 }}>
                <SearchOutline onClick={() => { this.setVisible(true) }} />
            </div>
        )
        const back = () =>
            Toast.show({
                content: '点击了返回区域',
                duration: 1000,
            })
        const tabs = [
            {
                key: 'home',
                title: '首页',
                icon: <AppOutline />,
                badge: Badge.dot,
            },
            {
                key: 'post',
                title: '发帖',
                icon: <AddSquareOutline />,
                badge: '5',
            },
            
            {
                key: '/info',
                title: '个人中心',
                icon: <UserOutline />,
            },
        ]

        return (
            <div>
                <Popup className="popup"
                    visible={this.state.visible}
                    onMaskClick={() => {
                        this.setVisible(false)
                    }}
                    position='right'
                    bodyStyle={{ minWidth: '100vw' }}
                >
                <div className="searchReturn"><LeftOutline fontSize={18} onClick={() => { this.setVisible(false) }} /></div>

                <div className="searchBar">
                    <SearchBar
                        placeholder='请输入内容'
                        showCancelButton={() => false}
                        style={{
                            '--border-radius': '100px',
                            '--background': '#e6e6e6',
                        }}
                        onCancel={() => { this.setVisible(false) }}
                    />
                    </div>
                    <div class="searchButton"><Button color='primary' size="mini" fill='none'>搜索</Button></div>
                </Popup>
                <NavBar className="topNav" right={right} onBack={back}>
                    <Tabs>
                        <Tabs.Tab title='最火' key='fruits' />
                        <Tabs.Tab title='个性化' key='vegetables' />
                    </Tabs>
                </NavBar>

                <div className="posts">
                    {Posts}
                    <BottomScrollListener onBottom={this.getPostsData.bind()} triggerOnNoScroll={true} />
                </div>

                <div className="bottomNav">
                    {/* <TabBar>
                        {tabs.map(item => (  
                            <TabBar.Item key={item.key} icon={item.icon} title={item.title}/> 
                        ))}
                    </TabBar> */}
                    <AppOutline />
                    <AddSquareOutline style={{ marginRight: 30, marginLeft: 30}} onClick = {() => {this.toPost(this.props.location.)}}/>
                    <UserOutline />
                </div>

                <footer className="foot">--已经到底啦--</footer>

            </div>
        )
    }
}


export default Home