const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs').promises; // Using promises for fs operations

const url = 'http://haktuts.blogspot.com/2018/09/Coin-master-50-free-spin-and-coin-link.html?m=1';
const outputFile = 'links-json/coin-master.json';

async function fetchLinks() {
  try {
    const { data } = await axios.get(url);
    const $ = cheerio.load(data);
    const links = [];

    $('a[href*="rewards.coinmaster.com"]').each((index, element) => {
      const link = $(element).attr('href');
      const text = $(element).text().trim();
      links.push({ href: link, text: text });
    });

    console.log('Fetched links:', links);
    await fs.writeFile(outputFile, JSON.stringify(links, null, 2));

    console.log(`Links saved to ${outputFile}`);
  } catch (err) {
    console.error('Error fetching or writing links:', err);
    process.exit(1); // Exit with an error code
  }
}

fetchLinks();
