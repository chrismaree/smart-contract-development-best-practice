# Installation Process

This document outlines how to run the tools discussed in this report. Each tool's installation process is outlined and discussed in turn, including all dependencies and libraries. Some of the code and installation processes are taken from the respective tools public repo.

## Maian
[Maian](https://github.com/MAIAN-tool/MAIAN)  is a tool for automatic detection of buggy Ethereum smart contracts of three different types: prodigal, suicidal and greedy. Maian processes contract's bytecode and tries to build a trace of transactions to find and confirm bugs. 

### Requirments for Maian: 
1. Go Ethereum, check https://ethereum.github.io/go-ethereum/install/
2. Solidity compiler, check http://solidity.readthedocs.io/en/develop/installing-solidity.html
3. Z3 Theorem prover, check https://github.com/Z3Prover/z3
4. web3, try pip install web3
5. PyQt5 (only for GUI Maian), try sudo apt install python-pyqt5

### Installation for Maian
No direct installation is required for Maian, assuming that your system meets the requirements stipulated above. Simply clone the repo and run the scripts as depicted in the evaluating contracts section. The repo can be cloned as follows:

	$ git clone git@github.com:MAIAN-tool/MAIAN.git

### Evaluating Contracts
Maian analyzes smart contracts defined in a file <contract file> with:

1. Solidity source code, use -s <contract file> <main contract name>
2. Bytecode source, use -bs <contract file>
3. Bytecode compiled (i.e. the code sitting on the blockchain), use -b <contract file>

Maian checks for three types of buggy contracts:

1. Suicidal contracts (can be killed by anyone, like the Parity Wallet Library contract), use -c 0
2. Prodigal contracts (can send Ether to anyone), use -c 1
3. Greedy contracts (nobody can get out Ether), use -c 2

For instance, to check if the contract ParityWalletLibrary.sol given in Solidity source code with WalletLibrary as main contract is suicidal use

	$ python maian.py -s ParityWalletLibrary.sol WalletLibrary -c 0
	
Caveats with running this script: sometimes it is hard to get web3.py to play nicely with your python version. Added to this, z3 is quite hard to install. Ensure that the python version you install z3 with is the same for web3.
	
## Solhint
[Solhint](https://github.com/protofire/solhint) is an open source project for linting solidity code.  This project provide both security and style guide validations.

### Installation of Solhint:
Can install directly using node package manager
	npm install -g solhint

	# verify that it was installed correctly
	solhint -V
	
###Evaluating Contracts

For linting Solidity files you need to run Solhint with one or more Globs as arguments. For example, to lint all files inside contracts directory, you can do:

	solhint "contracts/**/*.sol"
To lint a single file:

	solhint contracts/MyToken.sol	
