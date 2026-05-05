// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title SimpleStorage
/// @notice Basit veri saklama kontratı (factory tarafından deploy edilir)
contract SimpleStorage {
    uint256 public value;

    /// @param _value Başlangıç değeri
    constructor(uint256 _value) {
        value = _value;
    }
}

/// @title Factory Contract
/// @notice Kullanıcıların küçük fee karşılığında kontrat deploy etmesini sağlar
contract Factory {

    /// @notice Kontrat sahibi (fee'leri çeker)
    address public owner;

    /// @notice Deploy etmek için gereken minimum ücret
    uint256 public fee = 0.00001 ether;

    /// @notice Deploy edilen kontratları loglamak için event
    event Deployed(address indexed contractAddress, uint256 value);

    /// @notice Kontrat deploy edildiğinde owner atanır
    constructor() {
        owner = msg.sender;
    }

    /// @notice Yeni SimpleStorage kontratı deploy eder
    /// @param _value Kontratın başlangıç değeri
    /// @return Yeni deploy edilen kontrat adresi
    function deploy(uint256 _value) external payable returns (address) {
        // Kullanıcı yeterli fee gönderdi mi kontrol et
        require(msg.value >= fee, "Fee eksik");

        // Yeni kontrat oluştur
        SimpleStorage newContract = new SimpleStorage(_value);

        // Event yay (frontend veya indexer için önemli)
        emit Deployed(address(newContract), _value);

        return address(newContract);
    }

    /// @notice Kontratta biriken ETH'yi owner çeker
    function withdraw() external {
        require(msg.sender == owner, "Yetkisiz");

        payable(owner).transfer(address(this).balance);
    }
}
