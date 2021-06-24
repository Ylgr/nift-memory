import React, {Component} from "react";
import NiftMemoryDust from "./contracts/NiftMemoryDust.json";
import NiftMemoryTreasure from "./contracts/NiftMemoryTreasure.json";
import Web3 from "web3";
import {
    Card, Button, CardImg, CardTitle, CardText,
    CardSubtitle, CardBody, Col, Container, Row
} from 'reactstrap';
import Axios from "axios";

class App extends Component {
    state = {web3: null, dustContract: null, dustInfo: {}, treasureContract: null, treasureInfo: []};

    componentDidMount = async () => {
        try {
            // Get network provider and web3 instance.
            const web3 = new Web3('https://data-seed-prebsc-1-s1.binance.org:8545')

            const networkId = await web3.eth.net.getId()
            const dustContract = new web3.eth.Contract(NiftMemoryDust.abi, NiftMemoryDust.networks[networkId].address)

            const dustInfo = {
                name: await dustContract.methods.name().call(),
                symbol: await dustContract.methods.symbol().call(),
                totalSupply: await dustContract.methods.totalSupply().call()
            }

            const treasureContract = new web3.eth.Contract(NiftMemoryTreasure.abi, NiftMemoryTreasure.networks[networkId].address)

            let treasureInfo = []
            for(let tokenId = 1; tokenId <= 3; tokenId++) {
                const uri = await treasureContract.methods.tokenURI(tokenId).call()
                const response = await Axios(uri)
                response.data.owner = await treasureContract.methods.ownerOf(tokenId).call()
                treasureInfo.push(response.data)
            }
            this.setState({web3, dustContract, dustInfo, treasureContract, treasureInfo})
        } catch (error) {
            // Catch any errors for any of the above operations.
            alert(
                `Failed to load web3. Check console for details.`,
            );
            console.error(error);
        }
    };

    render() {
        return (
            <div className="App">
                <Container>
                    <Card>
                        <CardTitle>Currency</CardTitle>
                        <CardText>Name: {this.state.dustInfo.name}</CardText>
                        <CardText>Symbol: {this.state.dustInfo.symbol}</CardText>
                        <CardText>Total supply: {this.state.dustInfo.totalSupply}</CardText>
                    </Card>
                </Container>
                <Row>
                    {this.state.treasureInfo.map((e,index) => (
                        <Col md="4" key={index}>
                            <Card>
                                <CardImg top src={e.image} alt={e.name}/>
                                <CardBody>
                                    <CardTitle>{e.name}</CardTitle>
                                    <CardSubtitle>Owner: {e.owner}</CardSubtitle>
                                    <CardText>{e.description}</CardText>
                                </CardBody>
                            </Card>
                        </Col>
                    ))}


                </Row>

            </div>
        );
    }
}

export default App;
