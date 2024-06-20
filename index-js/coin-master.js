const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs');
const { pipeline } = require('stream');
const { promisify } = require('util');
const { join } = require('path');

const url = 'http://haktuts.blogspot.com/2018/09/Coin-master-50-free-spin-and-coin-link.html?m=1';
const outputFile = join(__dirname, 'links-json', 'coin-master.json');

const fetchData = async () => {
  try {
    const response = await axios.get(url, {
      timeout: 10000, // Adjust timeout as per your needs
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
      }
    });

    const $ = cheerio.load(response.data);
    const links = [];

    $('a[href*="rewards.coinmaster.com"]').each((index, element) => {
      const link = $(element).attr('href');
      const text = $(element).text().trim();
      links.push({ href: link, text: text });
    });

    return links;
  } catch (error) {
    console.error('Error fetching data:', error);
    throw error; // Rethrow error to handle in calling function
  }
};

const writeJsonToFile = async (data) => {
  try {
    await promisify(fs.writeFile)(outputFile, JSON.stringify(data, null, 2));
    console.log(`Links saved to ${outputFile}`);
  } catch (error) {
    console.error('Error writing JSON to file:', error);
    throw error; // Rethrow error to handle in calling function
  }
};

const run = async () => {
  try {
    const links = await fetchData();
    await writeJsonToFile(links);
  } catch (error) {
    console.error('Process failed:', error);
    process.exit(1); // Exit with an error code
  }
};

run();
