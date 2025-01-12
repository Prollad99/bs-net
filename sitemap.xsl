<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8"/>
  <html>
  <body>
    <h1>Sitemap</h1>
    <ul>
      <xsl:for-each select="sitemapindex/sitemap">
        <li>
          <a href="{loc}">
            <xsl:value-of select="loc"/>
          </a>
          - Last Modified: <xsl:value-of select="lastmod"/>
        </li>
      </xsl:for-each>
    </ul>
  </body>
  </html>
</xsl:stylesheet>