<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/sitemapindex">
    <html>
      <head>
        <title>Sitemap</title>
        <style>
          table { border-collapse: collapse; width: 100%; }
          table, th, td { border: 1px solid black; padding: 8px; text-align: left; }
          th { background-color: #f2f2f2; }
        </style>
      </head>
      <body>
        <h1>Sitemap</h1>
        <table>
          <thead>
            <tr>
              <th>URL</th>
              <th>Last Modified</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="sitemap">
              <tr>
                <td><a href="{loc}"><xsl:value-of select="loc"/></a></td>
                <td><xsl:value-of select="lastmod"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>