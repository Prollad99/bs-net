<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <html>
  <head>
    <title>Sitemap</title>
    <style>
      body { font-family: Arial, sans-serif; }
      table { width: 100%; border-collapse: collapse; }
      th, td { border: 1px solid #ddd; padding: 8px; }
      th { background-color: #f2f2f2; }
      a { color: blue; text-decoration: none; }
    </style>
  </head>
  <body>
    <h1>Sitemap</h1>
    <table>
      <thead>
        <tr>
          <th>Sitemap</th>
          <th>Last Modified</th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="sitemapindex/sitemap">
          <tr>
            <td><a href="{loc}"><xsl:value-of select="loc"/></a></td>
            <td><xsl:value-of select="lastmod"/></td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </body>
  </html>
</xsl:stylesheet>