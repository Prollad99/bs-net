const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs');

const url = 'http://haktuts.blogspot.com/2018/09/Coin-master-50-free-spin-and-coin-link.html?m=1';

axios.get(url).then(({ data }) => {
  const $ = cheerio.load(data);
  const links = [];

  $('a[href*="rewards.coinmaster.com"]').each((index, element) => {
    const link = $(element).attr('href');
    const text = $(element).text().trim();
    links.push({ href: link, text: text });
  });

  console.log('Fetched links:', links);
  fs.writeFileSync('links-json/coin-master.json', JSON.stringify(links, null, 2));
}).catch(err => {
  console.error('Error fetching links:', err);
  process.exit(1); // Exit with an error code
});