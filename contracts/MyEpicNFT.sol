// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;
// Primeiro importamos alguns contratos do OpenZeppelin.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Precisamos importar essa funcao de base64 que acabamos de criar
import { Base64 } from "./libraries/Base64.sol";

// Nós herdamos o contrato que importamos. Isso significa que
// teremos acesso aos métodos do contrato herdado.
contract MyEpicNFT is ERC721URIStorage {

    // Mágica dada pelo OpenZeppelin para nos ajudar a observar os tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // variavel baseSvg aqui que todos os nossos NFTs vao usar
    string baseSvg = "<svg version='1.0' xmlns='http://www.w3.org/2000/svg' width='344' height='285.333' viewBox='0 0 258 214'><path d='M186 15.1c-1.4.5-3.6 2-4.9 3.2-3.7 3.4-10 13.6-11.2 18.1-.6 2.3-2 6.3-3.2 8.9-1.9 4.7-2.2 4.8-5.1 4.2-1.7-.4-7.9-.9-13.8-1.2-14.6-.7-24.7 2.3-33.2 9.7-1.8 1.7-3.6 3-3.9 3-.2 0-1-2.1-1.7-4.6-1.3-4.5-7.7-14.2-11.6-17.5-4.2-3.6-22.2-12-28.1-13.1-7.2-1.3-11.4-.4-18.1 3.9-3.6 2.3-5.2 4.5-9.3 12.8C35.7 55 33 65.6 33 76.9c0 9.1 1.9 21.9 4.3 28.8 3.5 10.1 11.5 19.9 19 23.4 5.6 2.5 16 2.6 20.9.1l3.5-1.9.7 8.9c1.1 14.3 6.4 32.7 11.9 41.5 1.3 2.1 4.7 6.4 7.6 9.5 6.4 7 12.8 10 23.1 10.6 6.5.4 8.3.1 13.3-2.2 6.5-2.8 13.7-8.1 13.6-9.9 0-.7-2.3-2.7-5.2-4.6-4.6-3.1-6-3.4-12.2-3.5-3.8-.1-8 .3-9.2.7-2 .7-2.5.2-5.2-5.1-3.4-6.7-4.8-13.8-4.1-20l.5-4.3 5.8 4c9.5 6.7 14.8 8.8 26.2 10.4 1.8.2 2 .9 1.7 6.8-.5 8.5.4 9.3 8.4 7.8 10.4-1.8 9.8-1 9.1-10.3l-.5-8.1 2.5 5.2c1.3 2.9 2.8 5.3 3.3 5.3s2.6-1.1 4.6-2.5 4.3-2.5 5-2.5c2.3 0 1.6-3.4-1.7-7.8-2.9-4-3-4.2-.9-4.2 2.5 0 8-5.1 8-7.4 0-1.3.6-1.5 2.8-.9 4.9 1.2 6.7.9 6.7-1.2 0-1.5-1-2.2-4.2-2.9-2.4-.5-4.3-1.3-4.3-1.7 0-.5 1.8-1.4 4.1-2 4.3-1.3 5.9-3.3 4.1-5.1-1-1-1.7-.9-8.7 1.7-1.1.5.1-.9 2.8-3 4.6-3.7 6.2-7.5 3.1-7.5-1.4 0-8.5 4.7-9.2 6.1-.1.3-2.5.4-5.2.1-2.8-.2-7 .1-9.5.8-8.8 2.5-15.5-.9-25-12.6-6-7.4-8.1-8.7-9.1-5.9-.8 1.9 3 7 11.1 15.1 4.9 5 5.8 6.4 4.6 7.1-2.7 1.7-.4 4.1 5.4 5.4 5.6 1.3 5.7 1.3 3 2.6-1.6.9-2.5 2.1-2.3 3.1.4 1.8 1.9 2 5.3.7 1.9-.8 1.8-.6-.2 1.7-1.3 1.3-2.3 2.9-2.3 3.5 0 2.3 3.1 2.1 5.9-.2 3.8-3.3 5.1-3.2 2 .1-4.2 4.4-11.8 7.4-19.1 7.4-8.8 0-14.9-2.1-23.8-8-11.8-7.9-15-6.7-15 6 0 7.2 2.8 16.4 6.9 22.9 4.1 6.4 5.8 7.8 12.6 10.6l5.6 2.3-3.2 1.1c-4.5 1.6-7.8 1.4-15.1-.9-5.5-1.7-7.4-2.9-12.5-8.3-6.5-6.8-9.8-12.5-13.1-22.7-5.4-16.8-6.8-33.9-3.2-39.8 1.1-1.8 2-3.9 2-4.7s.8-3 1.7-5c1.3-2.6 1.4-3.8.5-4.7-1.7-1.7-3.8.5-7.3 7.8-2.5 5.4-3.8 6.9-8.2 9.4-8.8 5.1-17.2 3.6-25.3-4.5-9.1-9-13.4-22.4-13.4-41.3 0-12.9 1.2-18.5 6.9-31.2 4.2-9.5 5.1-10.8 9.6-13.9 4.7-3.1 5.4-3.3 11.5-2.9 5.5.4 8.4 1.4 17.6 6.1 12.7 6.5 16.7 10.8 21.3 22.9 3.5 9.1 5 9.5 11.8 3.4 10.7-9.6 26-12.8 41.8-8.7 3.8 1 7.5 1.7 8 1.4 1.1-.4 7.5-14.3 7.5-16.3 0-2.7 6.2-13 9.9-16.3 4.5-4.1 8.9-5.2 16.3-4.3 7.6 1 11.3 2.9 16.8 8.6 8.2 8.5 9.8 17.8 6 37.2-4.2 21.7-7.8 31-13 34.1-3.6 2.2-7.5 2.1-12.7-.2-3.5-1.6-4.4-1.7-5.3-.6-.8 1-.6 1.8 1.1 3.4 2.8 2.6 7.4 3.5 14.2 2.8 4.5-.4 5.6-1 8.8-4.6 6.3-7.1 12.8-32.2 13.1-50.9.2-11.8-1.8-17.2-9-24.5-7.2-7.4-11-9-22.2-9.4-5.2-.2-10.6.2-12 .8zm-3.8 123.5c.7 8.8-3.7 12.1-8.6 6.4-1.8-2.2-2.6-4.3-2.6-7.1V134h10.8l.4 4.6zm-7.4 19c2.2 3.4 2.3 3.6.5 4.9-1 .8-2.1 1.1-2.4.7-1.2-1.3-2.9-7.4-2.3-8.3.9-1.6 1.8-1 4.2 2.7zm-12.8 9.3c.4 3.3.2 5.4-.5 5.6-.5.2-2.5.6-4.2.9l-3.3.5v-4.7c0-5.4.7-6.8 3.5-7.5 3.4-.8 4-.2 4.5 5.2zM141.1 184l2.4 1.9-5.1.1c-5.4 0-11.4-1.6-11.4-3.1 0-.5 2.7-.9 5.9-.9 4.4 0 6.5.5 8.2 2z'/><path d='M194.2 33c-6.8 2.8-13.7 11.4-13 16.3.5 3.7 4.1 2.8 4.9-1.1 1.7-8.5 14.2-14.7 17.9-9 2 3.1 2.6 22.6 1 30.4l-1.3 5.9-1.2-5c-1.2-5.6-6.3-15.1-9.4-17.9-2.3-2-5.1-1.5-5.1.9 0 .9 1.1 2.6 2.4 3.8 4.5 4 7.5 11.5 8.3 20.7.9 9.7 2.2 10.8 6 5.1 4.4-6.4 5.8-13.4 5.7-28.1 0-14-.5-16.1-4.7-20.8-2.2-2.4-7.2-2.9-11.5-1.2zm-124 12c-3 2.1-5.1 4.9-7.6 10.2-6.8 14.4-7.8 21.9-6.2 45.8.8 11.8 2 16 4.6 16 1.4 0 1.8-1.3 2.3-7.8.6-8 5.4-24.5 8.4-29.1 2.8-4.4 13.7-15.3 16.1-16.2 1.7-.6 2.2-1.6 2-3.1-.6-4.5-3.6-3.2-12.3 5.6-8.9 9-11.1 12.5-14.1 21.9-2.2 7.1-3.4 5.8-3.4-3.8C60 69 69.5 47 76.3 47c3.8 0 12.7 6.4 15.8 11.3 1.6 2.7 3.5 4.7 4.2 4.4 4.8-1.6-2.7-12.5-12-17.5-3.4-1.8-7-3.2-8-3.2-1.1 0-3.8 1.3-6.1 3zm105.5 24.7c-.8 1.6-1.9 4.4-2.6 6.3-.6 1.9-3.8 6.5-7.1 10.2-4.6 5.1-7.3 7.1-11.3 8.6-3.4 1.3-5.2 2.5-5.1 3.6 0 .9.1 5.2.2 9.6.2 6.3.6 8.4 2.1 9.9 2.5 2.5 9.8 3.5 15.6 2 8.9-2.3 10.5-9.4 5.3-24.4l-2.5-7 2.9-3.5c3.4-4.1 7.9-14.6 7.1-16.6-.8-2.3-3.1-1.6-4.6 1.3zm-5 37.2c.6 6-.1 7.2-4.4 8.5-2.3.7-2.3.6-2.3-7.9 0-7-.3-8.7-1.7-9.2s-1.2-1 1.3-3l2.9-2.3 1.9 4.2c1 2.3 2 6.7 2.3 9.7zm-13.2-3.2c0 2.7.4 6.5.8 8.5.9 4.1-.1 4.9-2.8 2.1-1.4-1.3-1.5-2.7-1-7.7.4-3.4.9-6.4 1.2-6.9 1.1-1.8 1.8-.3 1.8 4zm-56.1-26.5c-.4.6-.1 1.6.7 2.3.8.6 3.6 3.4 6.2 6.2l4.9 5-1.5 4.5c-.9 2.4-1.8 9.6-2.2 15.9l-.8 11.6 2.9 2.2c2.4 1.9 3.7 2.2 7.3 1.7 6.4-.9 11.2-3.6 13.3-7.6 1.6-2.8 1.8-4.8 1.4-10.3-.6-6.1-.5-6.7 1.3-6.7 2.3 0 3.5-2.5 1.8-3.8-.7-.5-3.2-1.2-5.6-1.6-6.5-1-8.8-2.6-17.5-12-7.6-8.2-10.6-10-12.2-7.4zm27.4 32.1c.2 4.7 0 7.7-.7 8.1-.7.5-1.1-1-1.1-4.6 0-2.9-.3-6.3-.6-7.6-.7-2.4-3.3-2.9-5.2-1-1.6 1.6-1.5 10.7.2 14 1.6 3.1.7 3.8-4.6 3.8h-3.1l.6-11.3c.9-16.6.6-16.1 8-12.1l6.1 3.2.4 7.5z'/><rect width='90%' height='30' x='5%' y='20%' fill='#fff'/><rect width='100%' height='100%' style='fill-opacity:0;stroke:#000;stroke-width:10' /><text x='50%' y='28%' class='prefix__base' dominant-baseline='middle' text-anchor='middle'>";

    //  tres listas, cada uma com seu grupo de palavras aleatorias
    string[] firstWords = ["GALINHA", "CACHORRO", "TATU", "BUFALO", "AVESTRUZ", "CISNE", "HIPOPOTAMO", "VACA", "CAVALO", "POMBA","PATO", "CARACOL", "ESQUILO", "PEIXE", "LOBO","GATO", "BALEIA", "CANGURU", "GORILA", "BORBOLETA"];
    string[] secondWords = ["LARANJA", "BRANCO", "AMARELO", "VERDE", "ROSA", "ROXO", "AZUL", "PRETO", "MARROM", "CINZA", "VERMELHO", "LILAS", "TURQUESA", "MARFIM", "PRATEADO", "DOURADO", "BEGE"];
    string[] thirdWords = ["MOTORISTA", "ENGENHEIRO", "PROFESSOR", "ATOR", "ADVOGADO", "CARTEIRO", "MECANICO", "ESTUDANTE", "YOUTUBER", "AGRICULTOR", "GARCOM", "VENDEDOR", "DESENHISTA", "REPORTER", "CIENTISTA", "ENFERMEIRO", "ATLETA", "BOMBEIRO", "POLICIAL", "PILOTO"];

    event NewEpicNFTMinted(address sender, uint256 tokenId);
    
    // Nós precisamos passar o nome do nosso token NFT e o símbolo dele.
    constructor() ERC721 ("RataoNFT", "SQUARE"){
      console.log("Esse eh meu contrato de NFT! Tchu-hu");
    }

    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
      // Crio a 'semente' para o gerador aleatorio
      uint256 rand = random(string(abi.encodePacked("PRIMEIRA_PALAVRA", Strings.toString(tokenId))));
      // pego o numero no maximo ate o tamanho da lista, para nao dar erro de indice.
      rand = rand % firstWords.length;
      return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
      uint256 rand = random(string(abi.encodePacked("SEGUNDA_PALAVRA", Strings.toString(tokenId))));
      rand = rand % secondWords.length;
      return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
      uint256 rand = random(string(abi.encodePacked("TERCEIRA_PALAVRA", Strings.toString(tokenId))));
      rand = rand % thirdWords.length;
      return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    // Uma função que o nosso usuário irá chamar para pegar sua NFT.
    function makeAnEpicNFT() public {

      // Pega o tokenId atual, que começa por 0.
      uint256 newItemId = _tokenIds.current();

      string memory first = pickRandomFirstWord(newItemId);
      string memory second = pickRandomSecondWord(newItemId);
      string memory third = pickRandomThirdWord(newItemId);
      string memory combinedWord = string(abi.encodePacked(first, " ", second, " ", third));

      string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

      // pego todos os metadados de JSON e codifico com base64.
      string memory json = Base64.encode(
        bytes(
          string(
            abi.encodePacked(
              '{"name": "',
              // Definimos aqui o titulo do nosso NFT sendo a combinacao de palavras.
              combinedWord,
              '", "description": "Uma colecao aclamada e famosa de NFTs de um Rato Louco.", "image": "data:image/svg+xml;base64,',
              // Adicionamos data:image/svg+xml;base64 e acrescentamos nosso svg codificado com base64.
              Base64.encode(bytes(finalSvg)),
              '"}'
            )
          )
        )
      );

      // Assim como antes, prefixamos com data:application/json;base64
      string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
      );

      // Minta ("cunha") o NFT para o sender (quem ativa o contrato) usando msg.sender.
      _safeMint(msg.sender, newItemId);

      // Vamos definir essa tokenURI depois!
      _setTokenURI(newItemId, finalTokenUri);

      // Incrementa o contador para quando o próximo NFT for mintado.
      _tokenIds.increment();
      console.log("Um NFT com ID %s foi cunhado para %s", newItemId, msg.sender);

      emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}