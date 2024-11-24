
/*!
 * JSQR - JavaScript Quick Response Code Encoder Library v1.0.2
 * http://www.jsqr.de
 *
 * Copyright 2011-2015, Jens Duttke
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.jsqr.de/license
 *
 * Date: 2015-11-13
 *
 * cleaned from unused code - christof.kaser@gmail.com
 */

(function () {

	var Matrix = function (input, encodeMode, ecLevel) {
		var _this = this;
		var matrix = encodeMatrix(processInput(input), encodeMode, ecLevel);

		this.pixelWidth = function () {
			return (matrix.length + (_this.margin << 1)) * _this.scale;
		};
		this.draw = function (canvas, left, top) {
			var	context = canvas.getContext('2d'),
				scale = this.scale,
				margin = this.margin,
				x, y;
	
			for (y = 0; y < matrix.length; y++) {
				for (x = 0; x < matrix[y].length; x++) {
					if (matrix[y][x]) {
						context.fillRect(left + (x + margin) * scale, top + (y + margin) * scale, scale, scale);
					}
				}
			}
		};
	
	};
	
	// ==== Private Constants =================================================
	
	var	/* Should be "const", but the IE doesn't support that */
		VI = {										// Describing the versionInfo-Array
			TOTAL_BYTES: 0,							// Total data bytes
			REMAINDER_BITS: 1,						// Number of Remainder bits
			ECC_BYTES: 2,							// Number of ECC bytes [M, L, H, Q]
			EC_BLOCKS: 3,							// Number of Error Correction Blocks [Short, Long]
			ALIGNMENT_PATTERN_POSITION_OFFSET: 4,	// Alignment Pattern position offsets
			VERSION_PATTERN: 5						// Version Information Pattern
		},
		versionInfo = [
			null,
			[  26, 0, [  10,   7,   17,   13], [[ 1,  0], [ 1,  0], [ 1,  0], [ 1,  0]],  0, null],		// 1
			[  44, 7, [  16,  10,   28,   22], [[ 1,  0], [ 1,  0], [ 1,  0], [ 1,  0]], 12, null],
			[  70, 7, [  26,  15,   44,   36], [[ 1,  0], [ 1,  0], [ 2,  0], [ 2,  0]], 16, null],
			[ 100, 7, [  36,  20,   64,   52], [[ 2,  0], [ 1,  0], [ 4,  0], [ 2,  0]], 20, null],
			[ 134, 7, [  48,  26,   88,   72], [[ 2,  0], [ 1,  0], [ 2,  2], [ 2,  2]], 24, null],		// 5
			[ 172, 7, [  64,  36,  112,   96], [[ 4,  0], [ 2,  0], [ 4,  0], [ 4,  0]], 28, null],
			[ 196, 0, [  72,  40,  130,  108], [[ 4,  0], [ 2,  0], [ 4,  1], [ 2,  4]], 16, 0x07c94],
			[ 242, 0, [  88,  48,  156,  132], [[ 2,  2], [ 2,  0], [ 4,  2], [ 4,  2]], 18, 0x085bc],
			[ 292, 0, [ 110,  60,  192,  160], [[ 3,  2], [ 2,  0], [ 4,  4], [ 4,  4]], 20, 0x09a99],
			[ 346, 0, [ 130,  72,  224,  192], [[ 4,  1], [ 2,  2], [ 6,  2], [ 6,  2]], 22, 0x0a4d3],	// 10
			[ 404, 0, [ 150,  80,  264,  224], [[ 1,  4], [ 4,  0], [ 3,  8], [ 4,  4]], 24, 0x0bbf6],
			[ 466, 0, [ 176,  96,  308,  260], [[ 6,  2], [ 2,  2], [ 7,  4], [ 4,  6]], 26, 0x0c762],
			[ 532, 0, [ 198, 104,  352,  288], [[ 8,  1], [ 4,  0], [12,  4], [ 8,  4]], 28, 0x0d847],
			[ 581, 3, [ 216, 120,  384,  320], [[ 4,  5], [ 3,  1], [11,  5], [11,  5]], 20, 0x0e60d],
			[ 655, 3, [ 240, 132,  432,  360], [[ 5,  5], [ 5,  1], [11,  7], [ 5,  7]], 22, 0x0f928],	// 15
			[ 733, 3, [ 280, 144,  480,  408], [[ 7,  3], [ 5,  1], [ 3, 13], [15,  2]], 24, 0x10b78],
			[ 815, 3, [ 308, 168,  532,  448], [[10,  1], [ 1,  5], [ 2, 17], [ 1, 15]], 24, 0x1145d],
			[ 901, 3, [ 338, 180,  588,  504], [[ 9,  4], [ 5,  1], [ 2, 19], [17,  1]], 26, 0x12a17],
			[ 991, 3, [ 364, 196,  650,  546], [[ 3, 11], [ 3,  4], [ 9, 16], [17,  4]], 28, 0x13532],
			[1085, 3, [ 416, 224,  700,  600], [[ 3, 13], [ 3,  5], [15, 10], [15,  5]], 28, 0x149a6],	// 20
			[1156, 4, [ 442, 224,  750,  644], [[17,  0], [ 4,  4], [19,  6], [17,  6]], 22, 0x15683],
			[1258, 4, [ 476, 252,  816,  690], [[17,  0], [ 2,  7], [34,  0], [ 7, 16]], 24, 0x168c9],
			[1364, 4, [ 504, 270,  900,  750], [[ 4, 14], [ 4,  5], [16, 14], [11, 14]], 24, 0x177ec],
			[1474, 4, [ 560, 300,  960,  810], [[ 6, 14], [ 6,  4], [30,  2], [11, 16]], 26, 0x18ec4],
			[1588, 4, [ 588, 312, 1050,  870], [[ 8, 13], [ 8,  4], [22, 13], [ 7, 22]], 26, 0x191e1],	// 25
			[1706, 4, [ 644, 336, 1110,  952], [[19,  4], [10,  2], [33,  4], [28,  6]], 28, 0x1afab],
			[1828, 4, [ 700, 360, 1200, 1020], [[22,  3], [ 8,  4], [12, 28], [ 8, 26]], 28, 0x1b08e],
			[1921, 3, [ 728, 390, 1260, 1050], [[ 3, 23], [ 3, 10], [11, 31], [ 4, 31]], 24, 0x1cc1a],
			[2051, 3, [ 784, 420, 1350, 1140], [[21,  7], [ 7,  7], [19, 26], [ 1, 37]], 24, 0x1d33f],
			[2185, 3, [ 812, 450, 1440, 1200], [[19, 10], [ 5, 10], [23, 25], [15, 25]], 26, 0x1ed75],	// 30
			[2323, 3, [ 868, 480, 1530, 1290], [[ 2, 29], [13,  3], [23, 28], [42,  1]], 26, 0x1f250],
			[2465, 3, [ 924, 510, 1620, 1350], [[10, 23], [17,  0], [19, 35], [10, 35]], 26, 0x209d5],
			[2611, 3, [ 980, 540, 1710, 1440], [[14, 21], [17,  1], [11, 46], [29, 19]], 28, 0x216f0],
			[2761, 3, [1036, 570, 1800, 1530], [[14, 23], [13,  6], [59,  1], [44,  7]], 28, 0x228ba],
			[2876, 0, [1064, 570, 1890, 1590], [[12, 26], [12,  7], [22, 41], [39, 14]], 24, 0x2379f],	// 35
			[3034, 0, [1120, 600, 1980, 1680], [[ 6, 34], [ 6, 14], [ 2, 64], [46, 10]], 26, 0x24b0b],
			[3196, 0, [1204, 630, 2100, 1770], [[29, 14], [17,  4], [24, 46], [49, 10]], 26, 0x2542e],
			[3362, 0, [1260, 660, 2220, 1860], [[13, 32], [ 4, 18], [42, 32], [48, 14]], 26, 0x26a64],
			[3532, 0, [1316, 720, 2310, 1950], [[40,  7], [20,  4], [10, 67], [43, 22]], 28, 0x27541],
			[3706, 0, [1372, 750, 2430, 2040], [[18, 31], [19,  6], [20, 61], [34, 34]], 28, 0x28c69]	// 40
		],
		formatInfo = [
			[0x5412, 0x5125, 0x5e7c, 0x5b4b, 0x45f9, 0x40ce, 0x4f97, 0x4aa0],
			[0x77c4, 0x72f3, 0x7daa, 0x789d, 0x662f, 0x6318, 0x6c41, 0x6976],
			[0x1689, 0x13be, 0x1ce7, 0x19d0, 0x0762, 0x0255, 0x0d0c, 0x083b],
			[0x355f, 0x3068, 0x3f31, 0x3a06, 0x24b4, 0x2183, 0x2eda, 0x2bed]
		],
		pdp = [	// Position Detection Pattern
			[1,1,1,1,1,1,1],
			[1,0,0,0,0,0,1],
			[1,0,1,1,1,0,1],
			[1,0,1,1,1,0,1],
			[1,0,1,1,1,0,1],
			[1,0,0,0,0,0,1],
			[1,1,1,1,1,1,1]
		],
		ap = [	// Alignment Pattern
			[1,1,1,1,1],
			[1,0,0,0,1],
			[1,0,1,0,1],
			[1,0,0,0,1],
			[1,1,1,1,1]
		],
		maskPattern = [
			function (j, i) { return (i + j) % 2 === 0; },
			function (j, i) { return i % 2 === 0; },
			function (j, i) { return j % 3 === 0; },
			function (j, i) { return (i + j) % 3 === 0; },
			function (j, i) { return (Math.floor(i / 2) + Math.floor(j / 3)) % 2 === 0; },
			function (j, i) { return (i * j) % 2 + (i * j) % 3 === 0; },
			function (j, i) { return ((i * j) % 2 + (i * j) % 3) % 2 === 0; },
			function (j, i) { return ((i * j) % 3 + (i + j) % 2) % 2 === 0; }
		],
		BIT_TYPE = {
			FINDER: 0x02,
			SEPARATOR: 0x04,
			TIMING: 0x08,
			ALIGNMENT: 0x10,
			VERSION: 0x20,
			FORMAT: 0x40,
			DATA: 0x80
		};
	
	// ==== Private Encoding Function =========================================
	
	function encodeMatrix (data, encodeMode, ecLevel) {
		var	i, j, x, y, len, version;
	
		// ==== Step 1: Data Encodation ===========================================
	
		// ---- Data analysis & Bit stream generation -----------------------------
	
		var	bitStream = new Array(versionInfo[versionInfo.length - 1][VI.TOTAL_BYTES] * 8),
			bitStreamLen = 0,
			cciLength,	// Number of bits in Character Count Indicator
			minVersion;
	
		for (i = 0; i < data.length; i++) {
			bitStreamLen = arrayCopy(bitStream, bitStreamLen, toBits(data[i], 8));
		}

		minVersion = getMinVersionByBits(bitStreamLen + 4 + 8, ecLevel);
		if (minVersion > 0) {
			if (minVersion < Math.abs(version)) { minVersion = Math.abs(version); }
			if (minVersion >= 1 && minVersion <= 9) {
				cciLength = 8;
			} else {
				minVersion = getMinVersionByBits(bitStreamLen + 4 + 16, ecLevel);
				if (minVersion > 0) {
					if (minVersion < Math.abs(version)) { minVersion = Math.abs(version); }
					if (minVersion >= 10 && minVersion <= 40) {
						cciLength = 16;
					} else {
						throw new RangeError('Bug in version detection');
					}
				} else {
					throw new RangeError('Too much data');
				}
			}
		} else {
			throw new RangeError('Too much data');
		}
		version = minVersion;
	
		bitStream = toBits(encodeMode & 0xf, 4).concat(toBits(data.length, cciLength)).concat(bitStream);
		bitStreamLen += (4 + cciLength);
	
		// ---- Size check --------------------------------------------------------
	
		var maxDataBits = versionInfo[version][VI.TOTAL_BYTES] - versionInfo[version][VI.ECC_BYTES][ecLevel] << 3;
	
		if (bitStreamLen > maxDataBits) {
			throw new RangeError('Too much data for the selected version');
		}
	
		// ---- Append Terminator & Padding ---------------------------------------
	
		var termLength = maxDataBits - bitStreamLen;
		if (termLength > 4) { termLength = 4; }
		bitStreamLen = arrayCopy(bitStream, bitStreamLen, typedArray(termLength, 0));
		bitStreamLen = arrayCopy(bitStream, bitStreamLen, typedArray((8 - (bitStreamLen % 8)) % 8, 0));
	
		for (i = 0, len = (maxDataBits - bitStreamLen) >>> 3; i < len; i++) {
			bitStreamLen = arrayCopy(bitStream, bitStreamLen, i & 1 ? [0,0,0,1,0,0,0,1] : [1,1,1,0,1,1,0,0]);
		}
	
		// ---- Bit stream to codeword conversion / Subdivision into blocks -------
	
		// dataBlockSize contains the size of shortest data block, the longest data block has a size of dataBlockSize+1
		var	dataBlockSize = Math.floor((versionInfo[version][VI.TOTAL_BYTES] - versionInfo[version][VI.ECC_BYTES][ecLevel]) / (versionInfo[version][VI.EC_BLOCKS][ecLevel][0] + versionInfo[version][VI.EC_BLOCKS][ecLevel][1])),
			eccBlockSize = Math.floor(versionInfo[version][VI.ECC_BYTES][ecLevel]  / (versionInfo[version][VI.EC_BLOCKS][ecLevel][0] + versionInfo[version][VI.EC_BLOCKS][ecLevel][1])),
			dataBlocks = [],
			codeword = [];
	
		for (i = 0, len = versionInfo[version][VI.EC_BLOCKS][ecLevel][0]; i < len; i++) {
			codeword = [];
			for (j = 0; j < dataBlockSize; j++) {
				codeword.push(toByte(bitStream.splice(0, 8)));
			}
			dataBlocks.push(codeword);
		}
	
		for (i = 0, len = versionInfo[version][VI.EC_BLOCKS][ecLevel][1]; i < len; i++) {
			codeword = [];
			for (j = 0; j <= dataBlockSize; j++) {
				codeword.push(toByte(bitStream.splice(0, 8)));
			}
			dataBlocks.push(codeword);
		}
	
		// ==== Step 2: Error Correction Codeword generation ======================
	
		// ---- Galois Field Generation -------------------------------------------
	
		var gf = [], gfRev = [];
		j = 1;
		for (i = 0; i < 255; i++) {
			gf.push(j);
			gfRev[j] = i;
			j <<= 1;
			if (j > 0xff) { j = 0x11d ^ j; }	// pp = 285 = 0x11d
		}
	
		// ---- Generator Polynomial Generation -----------------------------------
	
		var gp = [1];
		for (i = 0, len = eccBlockSize; i < len; i++) {
			gp[i + 1] = 1;
	
			for (j = i; j > 0; j--) {
				if (gp[j] > 0) {
					gp[j] = gp[j - 1] ^ gf[(gfRev[gp[j]] + i) % 0xff];
				} else {
					gp[j] = gp[j - 1];
				}
			}
			gp[0] = gf[(gfRev[gp[0]] + i) % 0xff];
		}
	
		var gpi = [];	// inverted order
		for (i = gp.length - 1; i >= 0; i--) {
			gpi.push(gp[i]);
		}
	
		// ---- Error Correction Code Generation ----------------------------------
	
		var eccBlocks = [];
	
		for (j = 0; j < dataBlocks.length; j++) {
			eccBlocks[j] = [].concat(dataBlocks[j]).concat(typedArray(eccBlockSize, 0));
	
			var firstByte;
			while (eccBlocks[j].length >= gpi.length) {
				firstByte = eccBlocks[j][0];
				for (i = 0; i < gpi.length; i++) {
					eccBlocks[j][i] ^= gf[(gfRev[gpi[i]] + gfRev[firstByte]) % 0xff];
				}
				if (eccBlocks[j].shift() !== 0) {
					throw new Error('Bug while generating the ECC');
				}
			}
		}
	
		// ---- Interleave Blocks / Back-conversion into bit stream ---------------
	
		bitStream = new Array(versionInfo[versionInfo.length - 1][VI.TOTAL_BYTES] * 8);
		bitStreamLen = 0;
	
		for (i = 0; i <= dataBlockSize; i++) {
			for (j = 0; j < dataBlocks.length; j++) {
				if (i < dataBlocks[j].length) {
					bitStreamLen = arrayCopy(bitStream, bitStreamLen, toBits(dataBlocks[j][i], 8));
				}
			}
		}
	
		for (i = 0; i < eccBlockSize; i++) {
			for (j = 0; j < eccBlocks.length; j++) {
				if (i < eccBlocks[j].length) {
					bitStreamLen = arrayCopy(bitStream, bitStreamLen, toBits(eccBlocks[j][i], 8));
				}
			}
		}
	
		// ==== Step 3: Module placement in matrix ================================
	
		// ---- Matrix Initialization ---------------------------------------------
	
		var noOfModules = 17 + (version << 2),
			matrix = new Array(noOfModules);
	
		for (i = 0; i < noOfModules; i++) {
			matrix[i] = typedArray(noOfModules, 0);
		}
	
		// ---- Finder Pattern ----------------------------------------------------
	
		matrixCopy(matrix, 0, 0, pdp, BIT_TYPE.FINDER);
		matrixCopy(matrix, 0, noOfModules - 7, pdp, BIT_TYPE.FINDER);
		matrixCopy(matrix, noOfModules - 7, 0, pdp, BIT_TYPE.FINDER);
	
		// ---- Separators --------------------------------------------------------
	
		for (i = 0; i < 8; i++) {
			// Top-left
			matrix[i][7] = BIT_TYPE.SEPARATOR;
			matrix[7][i] = BIT_TYPE.SEPARATOR;
	
			// Top-right
			matrix[i][noOfModules - 8] = BIT_TYPE.SEPARATOR;
			matrix[7][(noOfModules - 1) - i] = BIT_TYPE.SEPARATOR;
	
			// Bottom-left
			matrix[(noOfModules - 1) - i][7] = BIT_TYPE.SEPARATOR;
			matrix[noOfModules - 8][i] = BIT_TYPE.SEPARATOR;
		}
	
		// ---- Timing Pattern ----------------------------------------------------
	
		for (i = 8; i < (noOfModules - 8); i++) {
			matrix[i][6] = BIT_TYPE.TIMING | ((i + 1) % 2);
			matrix[6][i] = BIT_TYPE.TIMING | ((i + 1) % 2);
		}
	
		// ---- Alignment Pattern -------------------------------------------------
	
		if (version > 1) {
			var	appOffset = versionInfo[version][VI.ALIGNMENT_PATTERN_POSITION_OFFSET],
				appMax = (version * 4) + 10;
	
			y = appMax;
			while (true) {
				x = appMax;
				while (true) {
					if (!(
						(x === 6 && y === 6) ||
						(x === 6 && y === (noOfModules - 7)) ||
						(x === (noOfModules - 7) && y === 6)
					)) {
						matrixCopy(matrix, x - 2, y - 2, ap, BIT_TYPE.ALIGNMENT);
					}
					if (x === 6) { break; }
					x -= appOffset;
					if (x < 18) { x = 6; }
				}
				if (y === 6) { break; }
				y -= appOffset;
				if (y < 18) { y = 6; }
			}
		}
	
		// ---- Version Information -----------------------------------------------
	
		if (version >= 7) {
			var v = versionInfo[version][VI.VERSION_PATTERN];
			for (i = 0; i < 6; i++) {
				for (j = 0; j < 3; j++) {
					matrix[(noOfModules - 11) + j][i] = BIT_TYPE.VERSION | (v & 1);
					matrix[i][(noOfModules - 11) + j] = BIT_TYPE.VERSION | (v & 1);
					v = v >> 1;
				}
			}
		}
	
		// ---- Reserving space for Format Information ----------------------------
	
		for (i = 0; i < 8; i++) {
			matrix[(noOfModules - 1) - i][8] = BIT_TYPE.FORMAT | 0;
			matrix[8][(noOfModules - 1) - i] = BIT_TYPE.FORMAT | 0;
	
			if (i !== 6) {
				matrix[8][i] = BIT_TYPE.FORMAT | 0;
				matrix[i][8] = BIT_TYPE.FORMAT | 0;
			}
		}
		matrix[8][8] = BIT_TYPE.FORMAT | 0;
		matrix[noOfModules - 8][8] = BIT_TYPE.FORMAT | 1;
	
		// ---- Symbol character placement ----------------------------------------
	
		var	dir = -1;	// -1 = Upwards / +1 = Downwards
		x = y = noOfModules - 1;
		for (i = 0; i < bitStreamLen; i++) {
			matrix[y][x] = BIT_TYPE.DATA | bitStream[i];
			do {
				if (
					((x > 6) && ((x & 1) === 0)) ||
					((x < 6) && ((x & 1) === 1))
				) {
					x--;
				} else if (((dir === -1) && (y === 0)) || ((dir === 1) && (y === (noOfModules - 1)))) {
					if (x === 0) {	// reached end of pattern
						if (i < bitStreamLen - 1) {
							// This should be impossible
							throw new RangeError('Too much data while writing the symbol');
						}
						break;
					}
	
					dir = -dir;
					x--;
					if (x === 6) { x--; }
				} else {
					y += dir;
					x++;
				}
			} while (matrix[y][x] !== 0);
		}
	
		// ==== Step 4: Masking Pattern selection & add Format Information ========
	
		// ---- Create masked matrices & add Format Information modules -----------
	
		var	maskedMatrices = [],
			formatBits;
	
		for (i = 0; i < maskPattern.length; i++) {
			maskedMatrices[i] = [];
			for (y = 0; y < noOfModules; y++) {
				maskedMatrices[i][y] = [];
				for (x = 0; x < noOfModules; x++) {
					if (matrix[y][x] & BIT_TYPE.DATA) {
						maskedMatrices[i][y][x] = (matrix[y][x] ^ maskPattern[i](x, y)) & 1;
					} else {
						maskedMatrices[i][y][x] = matrix[y][x] & 1;
					}
				}
			}
	
			// Add Format Information modules
			formatBits = toBits(formatInfo[ecLevel][i], 15);
			maskedMatrices[i][noOfModules - 1][8] = maskedMatrices[i][8][0] = formatBits[0];
			maskedMatrices[i][noOfModules - 2][8] = maskedMatrices[i][8][1] = formatBits[1];
			maskedMatrices[i][noOfModules - 3][8] = maskedMatrices[i][8][2] = formatBits[2];
			maskedMatrices[i][noOfModules - 4][8] = maskedMatrices[i][8][3] = formatBits[3];
			maskedMatrices[i][noOfModules - 5][8] = maskedMatrices[i][8][4] = formatBits[4];
			maskedMatrices[i][noOfModules - 6][8] = maskedMatrices[i][8][5] = formatBits[5];
			maskedMatrices[i][noOfModules - 7][8] = maskedMatrices[i][8][7] = formatBits[6];
			maskedMatrices[i][8][noOfModules - 8] = maskedMatrices[i][8][8] = formatBits[7];
			maskedMatrices[i][8][noOfModules - 7] = maskedMatrices[i][7][8] = formatBits[8];
			maskedMatrices[i][8][noOfModules - 6] = maskedMatrices[i][5][8] = formatBits[9];
			maskedMatrices[i][8][noOfModules - 5] = maskedMatrices[i][4][8] = formatBits[10];
			maskedMatrices[i][8][noOfModules - 4] = maskedMatrices[i][3][8] = formatBits[11];
			maskedMatrices[i][8][noOfModules - 3] = maskedMatrices[i][2][8] = formatBits[12];
			maskedMatrices[i][8][noOfModules - 2] = maskedMatrices[i][1][8] = formatBits[13];
			maskedMatrices[i][8][noOfModules - 1] = maskedMatrices[i][0][8] = formatBits[14];
		}
	
		// ---- Evaluate: Scoring of masking results ------------------------------
	
		var	selectedMask = 0,
			selectedMaskScore = 0xffffffff,
			n1, n2, n3, n4, score;
	
		for (i = 0; i < maskPattern.length; i++) {
			n1 = n2 = n3 = n4 = score = 0;
			for (y = 0; y < noOfModules; y++) {
				for (x = 0; x < noOfModules; x++) {
					// Evaluate: Adjacent modules in row/column in same color
					if (
						(x >= 6) && (
							((
								maskedMatrices[i][y][x - 6] &
								maskedMatrices[i][y][x - 5] &
								maskedMatrices[i][y][x - 4] &
								maskedMatrices[i][y][x - 3] &
								maskedMatrices[i][y][x - 2] &
								maskedMatrices[i][y][x - 1] &
								maskedMatrices[i][y][x]
							) === 1) || ((
								maskedMatrices[i][y][x - 6] |
								maskedMatrices[i][y][x - 5] |
								maskedMatrices[i][y][x - 4] |
								maskedMatrices[i][y][x - 3] |
								maskedMatrices[i][y][x - 2] |
								maskedMatrices[i][y][x - 1] |
								maskedMatrices[i][y][x]
							) === 0)
						)
					) {
						n1++;
					}
					if (
						(y >= 6) && (
							((
								maskedMatrices[i][y - 6][x] &
								maskedMatrices[i][y - 5][x] &
								maskedMatrices[i][y - 4][x] &
								maskedMatrices[i][y - 3][x] &
								maskedMatrices[i][y - 2][x] &
								maskedMatrices[i][y - 1][x] &
								maskedMatrices[i][y][x]
							) === 1) || ((
								maskedMatrices[i][y - 6][x] |
								maskedMatrices[i][y - 5][x] |
								maskedMatrices[i][y - 4][x] |
								maskedMatrices[i][y - 3][x] |
								maskedMatrices[i][y - 2][x] |
								maskedMatrices[i][y - 1][x] |
								maskedMatrices[i][y][x]
							) === 0)
						)
					) {
						n1++;
					}
	
					// Evaluate: Block of modules in same color
					if (
						(x > 0 && y > 0) && (
							((
								maskedMatrices[i][y][x] &
								maskedMatrices[i][y][x - 1] &
								maskedMatrices[i][y - 1][x] &
								maskedMatrices[i][y - 1][x - 1]
							) === 1) || ((
								maskedMatrices[i][y][x] |
								maskedMatrices[i][y][x - 1] |
								maskedMatrices[i][y - 1][x] |
								maskedMatrices[i][y - 1][x - 1]
							) === 0)
						)
					) {
						n2++;
					}
	
					// Evaluate: 1,0,1,1,1,0,1 pattern in row/column
					if (
						(x >= 6) && (
							(maskedMatrices[i][y][x - 6]=== 1) &&
							(maskedMatrices[i][y][x - 5] === 0) &&
							(maskedMatrices[i][y][x - 4] === 1) &&
							(maskedMatrices[i][y][x - 3] === 1) &&
							(maskedMatrices[i][y][x - 2] === 1) &&
							(maskedMatrices[i][y][x - 1] === 0) &&
							(maskedMatrices[i][y][x] === 1)
						)
					) {
						n3++;
					}
					if (
						(y >= 6) && (
							(maskedMatrices[i][y - 6][x] === 1) &&
							(maskedMatrices[i][y - 5][x] === 0) &&
							(maskedMatrices[i][y - 4][x] === 1) &&
							(maskedMatrices[i][y - 3][x] === 1) &&
							(maskedMatrices[i][y - 2][x] === 1) &&
							(maskedMatrices[i][y - 1][x] === 0) &&
							(maskedMatrices[i][y][x] === 1)
						)
					) {
						n3++;
					}
	
					// Evaluate: Proportion of dark modules in entire symbol
					n4 += maskedMatrices[i][y][x];
				}
			}
	
			n4 = Math.abs(((100 * n4) / (noOfModules * noOfModules)) - 50) / 5;
			score = (n1 * 3) + (n2 * 3) + (n3 * 40) + (n4 * 10);
			if (score < selectedMaskScore) {
				selectedMaskScore = score;
				selectedMask = i;
			}
		}
	
		// ---- Apply masking pattern ---------------------------------------------
	
		for (y = 0; y < noOfModules; y++) {
			for (x = 0; x < noOfModules; x++) {
				if (matrix[y][x] & (BIT_TYPE.DATA | BIT_TYPE.FORMAT)) {
					matrix[y][x] = maskedMatrices[selectedMask][y][x];
				} else {
					matrix[y][x] = matrix[y][x] & 0x1;
				}
			}
		}
	
		return matrix;
	}
	
	// ************************************************************************
	// **** Global Private Functions ******************************************
	// ************************************************************************

	function processInput (data) {
		var dataArr = [];
		for (var i = 0; i < data.length; i++) {
			dataArr.push(data.charCodeAt(i));
		}

		return dataArr;
	}
	
	// Returns the smallest possible version to a given number of bits and errorCorrection level.
	function getMinVersionByBits (noOfBits, ecLevel) {
		for (var i = 1; i < versionInfo.length; i++) {
			if (noOfBits <= ((versionInfo[i][VI.TOTAL_BYTES] - versionInfo[i][VI.ECC_BYTES][ecLevel]) << 3)) {
				return i;
			}
		}
		return 0;
	}
	
	// Converts a number (data) into an array of bits of the given length.
	function toBits (data, length) {
		var dataArr = new Array(length);
		if ((typeof data === 'number') && (length > 0) && (length <= 32)) {
			for (var i = length - 1; i >= 0; i--) {
				dataArr[i] = data & 0x1;
				data >>= 1;
			}
			return dataArr;
		} else {
			throw new Error("Invalid parameters in toBits().");
		}
	}
	
	// Converts a part of an Array of Bits into an 8-bit number (0-255).
	function toByte (data) {
		var pos = 0;
		return	((data[pos    ] || 0) << 7) +
				((data[pos + 1] || 0) << 6) +
				((data[pos + 2] || 0) << 5) +
				((data[pos + 3] || 0) << 4) +
				((data[pos + 4] || 0) << 3) +
				((data[pos + 5] || 0) << 2) +
				((data[pos + 6] || 0) << 1) +
				((data[pos + 7] || 0));
	}
	
	// Generates an Array of a given size, prefilled with the given value.
	function typedArray (size, value) {
		var arr = new Array(size);
		for (var i = 0; i < size; i++) {
			arr[i] = value;
		}
		return arr;
	}
	
	function arrayCopy (dstArr, dstPos, srcArr) {
		for (var i = 0; i < srcArr.length; i++) {
			dstArr[dstPos + i] = srcArr[i];
		}
		return dstPos + srcArr.length;
	}
	
	// Copies an 2D-Array into another array
	function matrixCopy (dstArr, dstX, dstY, srcArr, xor) {
		var x, xLen, y, yLen;
		for (y = 0, yLen = srcArr.length; y < yLen; y++) {
			for (x = 0, xLen = srcArr[y].length; x < xLen; x++) {
				dstArr[dstY + y][dstX + x] = srcArr[y][x] ^ xor;
			}
		}
	}
	/**
 	* @constructor
 	*/
	JSQR = function () { };
	JSQR.prototype.Matrix = Matrix;

})();

var JSQR

function show_qr(data) {
	var qr = new JSQR();
	var matrix = new qr.Matrix(data, 4, 1);  // mode:BYTE, ecLevel:L (M:0)
	matrix.scale = 4;
	matrix.margin = 2;

	var pw = matrix.pixelWidth();
	canv.width = pw;
	canv.height = pw;
	matrix.draw(canv, 0, 0);
}
