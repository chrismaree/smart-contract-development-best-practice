# Paper Overview
This paper outlines and compares the current research into Ethereum smart contract development best practice relating to contract security. Previously hacked contracts are identified and discussed, breaking down exactly how the hack occured. A selection of the latest symbolic execution-based and static analysis tools are then used to analyze these contracts to try and identify the exploited vulnerabilities. Additional analysis tools are applied to these contracts such as linters. Three popular Ethereum code bases are then analysed, over a series, of release with two different Solidity linters, to generate sets of code metrics. These metrics can show a quantifiable improvement in contract quality over the development life cycle of the projects. Lastly, this report aims to provide a general guideline for smart contract security testing best practices, outlining a streamlined approach aimed at making contract development safer.

An overview of the tools discussed in the paper are now broken down. Each tool's installation process is outlined and discussed in turn, including all dependencies and libraries. Some of the code and installation processes are taken from the respective tools public repo.

# Symbolic Execution based Tools

## Maian
[Maian](https://github.com/MAIAN-tool/MAIAN)  is a tool for automatic detection of buggy Ethereum smart contracts of three different types: prodigal, suicidal and greedy. Maian processes contract's bytecode and tries to build a trace of transactions to find and confirm bugs. 

### Requirments for Maian
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
	
## Oyente
(Oyente)[https://github.com/melonproject/oyente] is An Analysis Tool for Smart Contracts, based off [this](http://www.comp.nus.edu.sg/~loiluu/papers/oyente.pdf) paper. The easiest way to use this tool is through a docker container, as follows:

### Installation of Oyente
	
	docker pull luongnguyen/oyente
	docker run -i -t luongnguyen/oyente
You will now enter the docker interactive terminal and can evaluate contracts from within it.

### Evaluating Contracts
To evaluate the greeter contract inside the container, run:

	cd /oyente/oyente
	python oyente.py -s greeter.sol
To evaluate other contracts, mount them into the docker container using a volume.

# Linters

## Solhint
[Solhint](https://github.com/protofire/solhint) is an open source project for linting solidity code.  This project provide both security and style guide validations.

### Installation of Solhint
Can install directly using node package manager
	npm install -g solhint

	# verify that it was installed correctly
	solhint -V
	
### Evaluating Contracts

For linting Solidity files you need to run Solhint with one or more Globs as arguments. For example, to lint all files inside contracts directory, you can do:

	solhint "contracts/**/*.sol"
To lint a single file:

	solhint contracts/MyToken.sol	
	
## Solium 
(Solium)[https://github.com/duaraghav8/Solium] analyzes your Solidity code for style & security issues and fixes them. Standardize Smart Contract practices across your organisation. Integrate with your build system. 

### Instalation for Solium
	
	npm install -g solium
Can then check if the instalation was sucessful with
	
	solium -V
	
### Evaluating Contracts
If its a new project, in the root directory of your DApp:

	solium --init
This creates 2 files for you:

1. .soliumignore - contains names of files and directories to ignore while linting
2. .soliumrc.json - contains configuration that tells Solium how to lint your project. You should modify this file to configure rules, plugins and sharable configs.
.soliumrc.json looks like:

	{
	  "extends": "solium:recommended",
	  "plugins": ["security"],
	  "rules": {
	    "quotes": ["error", "double"],
	    "indentation": ["error", 4]
	  }
	}

To lint a contract or directory of contracts

	solium -f foobar.sol
	solium -d contracts/
	
	
# Static Analisis tools used in paper
1. (SmartCheck)[https://tool.smartdec.net/]
2. (RemixIDE)[remix.ethereum.org]
3. (Securify)[https://securify.ch/]
	
# Repositories used in the paper
The paper outlines 3 open source repositories, used in testing of the linter utilities.
1. (Augur)[http://www.augur.net/]
2. (Zeppelin)[https://zeppelin.solutions/]
3. (Aragon)[https://aragon.one/]
